let
  nixpkgs = (import ./nixpkgs.nix).nixpkgs;
  pkgs = nixpkgs { };
  # In order to build docker on Mac OS, we have to build binary
  # suitable for running in docker on linux.
  pkgsCross = nixpkgs { crossSystem = pkgs.lib.systems.examples.gnu64; };
  # But for now it doesn't work without splicing dependencies
  # via callPackage machinery. So let's leave as is
  # project = (import ./default.nix) { pkgs = pkgsCross; };
  project = (import ./default.nix) { pkgs = pkgs; };
  # Standard docker image
  # import to docker daemon with
  # docker load < ./result
  # and then
  # docker run random-sum-0.1
  standard = pkgs.callPackage (
  { dockerTools }:
  dockerTools.buildImage {
    name = project.name;
    tag = "latest";
    contents = project;
    config = {
      Cmd = [ "${project}/bin/random-sum" ];
      WorkingDir = "${project}";
    };
  }) { };
  # Image with automatic layering, so glibc will take its own layer
  layered = pkgs.callPackage (
  { dockerTools }:
  dockerTools.buildLayeredImage {
    name = project.name;
    config.Cmd = [ "${project}/bin/random-sum" ];
  }) { };
in
  {
    inherit standard layered;
  }