let
  nixpkgs = builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixpkgs-aynin";
    # Commit hash
    url = https://github.com/nixos/nixpkgs/archive/8130f3c1c2bb0e533b5e150c39911d6e61dcecc2.tar.gz;
    sha256 = "154nrhmm3dk5kmga2w5f7a2l6j79dvizrg4wzbrcwlbvdvapdgkb";
  };
  pkgs = import nixpkgs {};
  sbt = pkgs.sbt.overrideAttrs (oldAttrs: rec {
    version = "0.13.18";
    src = pkgs.fetchurl {
      urls = [
        "https://piccolo.link/sbt-${version}.tgz"
        "https://github.com/sbt/sbt/releases/download/v${version}/sbt-${version}.tgz"
      ];
      sha256 = "0cdkhcys0wj0h5430m3zb8z6rp5pbr8yph8gw7qycqwfr8i27s5g";
    };
    buildInputs = [ pkgs.makeWrapper ];
    postFixup = with pkgs; ''
    wrapProgram $out/bin/sbt \
      --set CLANG_PATH      "${llvmPackages.clang}/bin/clang" \
      --set CLANGPP_PATH    "${llvmPackages.clang}/bin/clang" \
      --set CPATH           "${lib.makeSearchPathOutput "dev" "include" [ re2 zlib boehmgc libunwind llvmPackages.libcxxabi llvmPackages.libcxx ]}/c++/v1" \
      --set LIBRARY_PATH    "${lib.makeLibraryPath [ re2 zlib boehmgc libunwind llvmPackages.libcxxabi llvmPackages.libcxx ]}" \
      --set NIX_CFLAGS_LINK "-lc++abi -lc++"
    '';
  });
in
  pkgs.mkShell {
    buildInputs = [
      sbt

    ];
  }