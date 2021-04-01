{
  description = "romatthe.dev flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url   = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      pkgsFor = system: import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
      };
    in {
      overlay = final: prev: {
        blog = prev.callPackage ./blog.nix {};
      };
    } // flake-utils.lib.eachDefaultSystem (system: 
      let pkgs = pkgsFor system;
      in
        {
          defaultPackage = pkgs.blog;
          
          devShell = pkgs.mkShell {
            buildInputs = [ pkgs.zola ];
          };
        });
}
