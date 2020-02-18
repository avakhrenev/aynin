rec {
  # Define where to get nix expression from.
  nixpkgs-source = builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixpkgs-aynin";
    # Commit hash
    url = https://github.com/nixos/nixpkgs/archive/8130f3c1c2bb0e533b5e150c39911d6e61dcecc2.tar.gz;
    sha256 = "154nrhmm3dk5kmga2w5f7a2l6j79dvizrg4wzbrcwlbvdvapdgkb";
  };
  nixpkgs = import nixpkgs-source;
  # Actually evaluate the expression
  pkgs = nixpkgs { };
}