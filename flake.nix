{
  description = "Collatz Explorer in Goose";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    goose.url = "github:aardappel/goose";
  };

  outputs = { self, nixpkgs, goose }@inputs: {
    checks."x86_64-linux".build = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      goose-src = goose + "/";
    in pkgs.stdenv.mkDerivation {
      name = "goose-collatz-explorer-build";
      buildInputs = [ pkgs.cmake pkgs.gcc pkgs.git ];
      buildPhase = ''
        cmake -B build -S ${goose-src}
        cmake --build build -j
        ./build/goose build explore.goose
      '';
      installPhase = ''
        mkdir -p $out/bin
        cp explore $out/bin/
      '';
    };

    checks."x86_64-linux".test = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      goose-src = goose + "/";
    in pkgs.stdenv.mkDerivation {
      name = "goose-collatz-explorer-test";
      buildInputs = [ pkgs.cmake pkgs.gcc pkgs.git ];
      buildPhase = ''
        cmake -B build -S ${goose-src}
        cmake --build build -j
        ./build/goose build explore.goose
        ./build/goose build test_explore.goose
        ./explore
        ./test_explore
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
        echo "Build Goose compiler: cmake -B build -S <goose-repo> && cmake --build build -j"
        echo "Build explore.goose:  ./build/goose build explore.goose && ./explore"
        echo "Run unit tests:       ./build/goose build test_explore.goose && ./test_explore"
      '';
    };
  };
}
