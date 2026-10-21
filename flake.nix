{
  description = "Collatz Explorer in Goose";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    goose.url = "github:aardappel/goose";
    goose.flake = false;
  };

  outputs = { self, nixpkgs, goose }@inputs: let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  in {
    checks."x86_64-linux".default = pkgs.runCommand "goose-collatz-explorer" {
      src = ./.;
      buildInputs = [ pkgs.cmake pkgs.gcc ];
    } ''
      export HOME=$(mktemp -d)
      cp -r $src/* .
      # Build the Goose compiler from source (fetched as Flake input)
      cmake -B build -S ${goose}
      cmake --build build -j
      # Build the Goose programs
      ./build/goose build explore.goose
      ./build/goose build test_explore.goose
      mkdir -p $out/bin
      cp explore $out/bin/
      cp test_explore $out/bin/
      # Run tests
      ./explore
      ./test_explore
    '';
  };
}
