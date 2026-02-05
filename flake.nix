{
  description = "NixOS with Niri + Noctalia - Professional Development Environment";

  inputs = {
    # Nixpkgs 25.11 stable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Niri - scrollable-tiling Wayland compositor
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Noctalia - beautiful desktop shell for Wayland
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, niri, noctalia, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      
      modules = [
        # Main configuration files
        ./nixos/configuration.nix
        ./nixos/hardware-configuration.nix
        
        # Niri module
        niri.nixosModules.niri
        
        # Home Manager integration
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.river = import ./home;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
    
    # Formatter for nix files
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
