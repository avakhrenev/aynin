let
  project = import ./default.nix;
in
  pkgs.mkShell {
    inputsFrom = [ project ];
  }