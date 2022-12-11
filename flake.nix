{
  description = "Multirepo example package A";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system};
        program = pkgs.stdenv.mkDerivation {
          name = "multirepo-nix-example-package-A-0.0.0";
          phases = ["installPhase"];
          installPhase = ''
          mkdir -p $out/bin
          echo 'echo "Hello, package A"' > $out/bin/hello
          chmod +x $out/bin/hello
          '';
        };
      in rec {
        defaultPackage = program;
      }
    );
}
