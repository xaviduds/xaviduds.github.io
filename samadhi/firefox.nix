{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  buildInputs = with pkgs; [ firefox ];
  shellHook = ''firefox & exit'';
}
