self: super: {
  # modify dockerTools to pass env variables from upper layers
  dockerTools = self.callPackage ./pkgs/docker {};
  # Additional helpers to build docker images
  dockerHelpers = self.callPackage ./pkgs/docker-helpers {};
  push-docker-image = self.callPackage ./pkgs/push-docker-image {};
  # Used to set sbt options
  sbt = ( let version = "1.3.7"; in
    super.sbt.overrideAttrs (oldAttrs: {
      name = "sbt-${version}";
      src = super.fetchurl {
        urls = [
          "https://piccolo.link/sbt-${version}.tgz"
          "https://github.com/sbt/sbt/releases/download/v${version}/sbt-${version}.tgz"
        ];
        sha256 = "054qfbvhkh1w66f2nvsv1mvrkjc9qddzsnfrhmaqx79gglxllgc1";
      };
      patchPhase = ''
        ${oldAttrs.patchPhase}
        echo "
        -J-XX:MaxInlineLevel=20
        -J-Xss4m" >> conf/sbtopts
      '';
    })
  );
  # All the command line utilities, which are used during build.
  dash-build-env = super.callPackage ./pkgs/dash-build-env {};
}