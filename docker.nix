let
  pkgs = (import ./nixpkgs.nix).pkgs;
  project = (import ./default.nix);
  # Standard docker image
  # import to docker daemon with
  # docker load < ./result
  # and then
  # docker run random-sum-0.1
  standard = pkgs.dockerTools.buildImage {
    name = project.name;
    tag = "latest";
    contents = project;
    config = {
      Cmd = [ "${project}/bin/random-sum" ];
      WorkingDir = "${project}";
    };
  };
  # Image with automatic layering, so glibc will take its own layer
  layered = pkgs.dockerTools.buildLayeredImage {
    name = project.name;
    config.Cmd = [ "${project}/bin/random-sum" ];
  };
in
  {
    inherit standard layered;
  }