{ config, pkgs, ... }:

{
  imports = [
    ../home/cli/cli.nix
    ../home/desktop/desktop.nix

    ../home/languages/node.nix
    ../home/languages/python.nix
  ];

  programs = {
    obs-studio = {
      enable = true;

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi #optional AMD hardware acceleration
        obs-gstreamer
        obs-vkcapture
      ];
    };
  };

  home = {
    username = "beta";
    homeDirectory = "/home/beta";

    packages = with pkgs; [
      proton-pass
      discord
      teams-for-linux
      brave
      qbittorrent
      spotify

      obsidian

      jetbrains-toolbox
    ];
  };
}
