let
  project-name = "random-sum";
  pkgs = (import ./nixpkgs.nix).pkgs;
  version = "0.1";
  # scala-native 0.4.0-M2 only works with sbt-0.13.x. Next 0.4 version should be able to work with sbt 1.3.x
  old-sbt = pkgs.sbt.overrideAttrs (oldAttrs: rec {
    version = "0.13.18";
    src = pkgs.fetchurl {
      urls = [
        "https://piccolo.link/sbt-${version}.tgz"
        "https://github.com/sbt/sbt/releases/download/v${version}/sbt-${version}.tgz"
      ];
      sha256 = "0cdkhcys0wj0h5430m3zb8z6rp5pbr8yph8gw7qycqwfr8i27s5g";
    };
  });
  # Make sure we only consider ony relevant parts of the source files
  scala-native-source = pkgs.runCommand "${project-name}-source" { } ''
    mkdir -p $out/project
    cp -r ${./src} $out/src
    cp ${./build.sbt} $out/build.sbt
    cp ${./project/build.properties} $out/project/build.properties
    cp ${./project/scala-native.sbt} $out/project/scala-native.sbt
  '';
  # Options to run sbt to make it dump dependencies into workdir
  # and also use them from there.
  SBT_OPTS = ''
   -Dsbt.ivy.home=./deps/.ivy2/
   -Dsbt.boot.directory=./deps/.sbt/boot/
   -Dsbt.global.base=./deps/.sbt
   -Dsbt.global.staging=./deps/.staging
  '';
  # Actually download dependencies
  scala-native-deps = pkgs.stdenv.mkDerivation {
    pname = "${project-name}-deps";
    inherit version SBT_OPTS;
    buildInputs = [ old-sbt pkgs.findutils ];
    src = scala-native-source;
    # Running `compile` to retrieve compiler-interface.
    # Remove source files so we don't spend time compiling.
    buildPhase = ''
      mkdir -p ./deps/.ivy2/local
      cp -r ${old-sbt}/share/sbt/lib/local-preloaded/. ./deps/.ivy2/local
      rm -rf ./src/main/scala/*
      echo "object Hello { }" > ./src/main/scala/Hello.scala
      sbt "all update compile"
    '';
    installPhase = ''
      find ./deps/ -name "ivydata-*.properties" -delete
      find ./deps/ -name "*.lock"               -delete
      find ./deps/ -name "*.log"                -delete
      # Seems like this output is non-determenistic
      find ./deps/.ivy2/cache/org.scala-sbt -name "org.scala-sbt-compiler-interface-*" -print -exec rm -rf {} +
      find ./deps/.sbt/boot/scala-2.10.7/org.scala-sbt/sbt/ -name "org.scala-sbt-compiler-interface-*" -print -exec rm -rf {} +
      mkdir -p $out
      cp -r ./deps/. $out
    '';
    # This is fixed-output derivation, so sbt is allowed to hit network.
    # In return we have to tell nix what exactly we are going to build beforehand
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "0f32l8xnb7za1cbb6gpb0zhw0ndv8734bp6xwzvcmbp68acmm3nd";
  };

  result = pkgs.stdenv.mkDerivation {
    pname = project-name;
    inherit version SBT_OPTS;
    CLANG_PATH = pkgs.clang + "/bin/clang";
    CLANGPP_PATH = pkgs.clang + "/bin/clang++";

    src = scala-native-source;
    # use strictDeps so we won't confuse build-time and runtime dependencies
    # it's important when cross-building (i.e. building docker on MacOS)
    strictDeps = true;
    # nativeBuildInputs are used on a local platform during build-time
    nativeBuildInputs = with pkgs; [
      old-sbt
      clang
    ];
    # buildInputs are used on host platform during runtime
    # we may add excessive inputs, nix will strip irrelevant deps
    # after build. Google "nix automatic runtime dependencies".
    buildInputs = with pkgs; [
      boehmgc
      libunwind
      re2
      zlib
    ];
    buildPhase = ''
      mkdir -p ./deps
      cp -r ${scala-native-deps}/. ./deps
      # sbt tries to write to sbt.lock or ivy.lock e.t.c.
      chmod -R +w ./deps
      sbt nativeLink
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp target/scala-2.11/random-sum-out $out/bin/random-sum
    '';
  };
in result