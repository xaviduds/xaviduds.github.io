{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  buildInputs = with pkgs; [ nh ];
  shellHook = ''
    nh clean all & exit
  '';
}
