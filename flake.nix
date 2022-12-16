{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nur.url = github:nix-community/NUR;

    # leftwm.url = "github:leftwm/leftwm";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    { self, nixpkgs, home-manager, neovim-nightly-overlay }:
    let
      username = "semar";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          neovim-nightly-overlay.overlay
        ];
      };
    in
    {
      homeConfigurations = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home.nix
            {
              home = {
                username = "semar";
                homeDirectory = "/home/semar";
                stateVersion = "21.05";
              };
            }
          ];
        };
      };

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            # ({ config, pkgs, ... }: { nixpkgs.overlays = [ leftwm.overlay ]; })
            ./configuration.nix
          ];
        };
      };
    };
}
