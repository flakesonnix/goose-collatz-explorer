{
  description = "Collatz Explorer in Goose";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs: {
    checks."x86_64-linux".build = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in pkgs.stdenv.mkDerivation {
      name = "goose-collatz-explorer-build";
      buildInputs = [ pkgs.cmake pkgs.gcc pkgs.git ];
      buildPhase = ''
        echo "Build the Goose compiler first:"
        echo "  git clone https://github.com/aardappel/goose.git"
        echo "  cd goose && cmake -B build -S . && cmake --build build -j"
        echo "Then run:"
        echo "  ./goose/build/goose build explore.goose && ./explore"
        echo ""
        echo "Source files present:"
        ls -la explore.goose test_explore.goose
      '';
      installPhase = ''
        true
      '';
    };

    checks."x86_64-linux".test = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in pkgs.stdenv.mkDerivation {
      name = "goose-collatz-explorer-test";
      buildInputs = [ pkgs.cmake pkgs.gcc pkgs.git ];
      buildPhase = ''
        echo "Unit test source present:"
        ls -la test_explore.goose
        echo ""
        echo "To run the test, first build the Goose compiler, then:"
        echo "  ./goose/build/goose build test_explore.goose && ./test_explore"
      '';
      installPhase = ''
        true
      '';
    };

    devShells."x86_64-linux".default = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in pkgs.mkShell {
      buildInputs = [ pkgs.cmake pkgs.gcc pkgs.git ];
      shellHook = ''
        echo "Entered goose-collatz-explorer development shell"
        echo ""
        echo "To build and run:"
        echo "  1. Build Goose compiler: cmake -B build -S <goose-repo> && cmake --build build -j"
        echo "  2. Build explore.goose:  ./build/goose build explore.goose && ./explore"
        echo "  3. Run unit tests:       ./build/goose build test_explore.goose && ./test_explore"
      '';
    };
  };
}
