{ pkgs, ... }:
{
    fonts.packages = with pkgs; [
      corefonts
      google-fonts
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      (nerdfonts.override { fonts = [
        "FiraCode" "DroidSansMono" "JetBrainsMono"
        "IntelOneMono" "Inconsolata" "AnonymousPro"
      ]; })
      fira-code
      twemoji-color-font
      liberation_ttf
      intel-one-mono
      jetbrains-mono
      fontfinder
      ubuntu-sans
      ubuntu-sans-mono
    ];
}
