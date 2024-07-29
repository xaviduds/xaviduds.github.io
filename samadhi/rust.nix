{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    rustup
    clang
  ];
  RUST_BACKTRACE = 1;
  shellHook = ''
    rustup default stable
    rustup component add rustfmt
  '';
}
