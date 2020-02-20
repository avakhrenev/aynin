let
  pkgs = (import ./nixpkgs.nix).pkgs;
  project = import ./default.nix { inherit pkgs; };
in
  pkgs.mkShell {
    inputsFrom = [ project ];
  }