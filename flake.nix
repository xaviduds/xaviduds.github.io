{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      pythonPackages = pkgs.python311Packages;
      pyPkgs = with pythonPackages; [
        numpy
        plotly
        matplotlib
        pandas
        scikit-learn
      ];
    in {
      devShells.x86_64-linux = {
        default = pkgs.mkShell {
          buildInputs = [ (pkgs.python3.withPackages (ps: pyPkgs)) ];
        };
      };
    };
}
