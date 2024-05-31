# Alesauce's Neovim Config [![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This flake is a standalone [NixVim](https://github.com/nix-community/nixvim) configuration. Feel free to use it or riff on it as you please! Just note that this is obviously my personal config and is in no way, shape, or form meant to be a general-purpose config.

## Development
### Run once
1. Install Nix if you don't have it already. I use the [Determinate Systems Nix installer.](https://github.com/DeterminateSystems/nix-installer).1. Install [direnv](https://github.com/direnv/direnv)
1. Clone the repo
1. Run this command to allow direnv to set up the dev environment: `cd nixvim-flake; direnv allow`

### Run every change
1. `git pull`
1. `nix flake check --show-trace`
1. `nix build`

## Using this flake
### Run the flake directly
Run the following command:

```
nix run "github:alesauce/nixvim-flake <file name>"
```

### In another flake
Add this flake as an input:
```nix
{
    description = "Example flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixvim-flake = {
            url = "github:alesauce/nixvim-flake";
            inputs = {
                nixpkgs.follows = "nixpkgs";
            };
        };
    };
}
```

There are multiple ways to use it to replace the `nvim` binary that comes with nixpkgs. Here is where I use it in my system config flake:
1. https://github.com/alesauce/nix-home/blob/main/nix/overlays/neovim.nix
