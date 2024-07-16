{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    python312
    python312Packages.numpy
    python312Packages.pandas
    python312Packages.plotly
    python312Packages.packaging
    python312Packages.matplotlib
    python312Packages.scikit-learn
  ];
}
