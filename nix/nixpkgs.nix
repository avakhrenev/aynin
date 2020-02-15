# Pinned nixpkgs
rec {
  # Arguments to supply to nixpkgs
  pkgsArguments = {
    allowUnfree = true;
    packageOverrides = ps: {
      jdk = ps.openjdk11;
      jre = ps.openjdk11;
      nodejs = ps.nodejs-10_x;
    };
  };
  # to update, see the number of commits and the latest commit in
  # https://github.com/nixos/nixpkgs-channels/tree/nixos-unstable
  # 206,331 commits
  rev = "62d0993e87458fe640052e33eb5be7ba6e03d2c5";
  nixpkgs = builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-aynin";
  # Commit hash for nixos-unstable as of 2018-09-12
  url = "https://github.com/nixos/nixpkgs-channels/archive/${rev}.tar.gz";
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "1jg7g6cfpw8qvma0y19kwyp549k1qyf11a5sg6hvn6awvmkny47v";
};
  pkgs = import nixpkgs {
    config = pkgsArguments;
    overlays = [ (import ./overlay.nix) ];
  };
}