{ pkgs, ... }:
{
  fonts = {
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" "Liberation Serif" "Noto Serif CJK TC" "Noto Serif CJK JP" ];
        sansSerif = [ "Noto Sans" "Liberation Sans" "Arial" "Noto Sans CJK TC" "Noto Sans CJK JP" ];
        monospace = [ "JetBrainsMono Nerd Font" "Noto Sans Mono" "Noto Sans Mono CJK TC" "Noto Sans CJK JP" ];
        emoji = [ "Noto Color Emoji" "Twitter Color Emoji" ];
      };
    };

    packages = with pkgs; [
      corefonts
      google-fonts
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      (nerdfonts.override { fonts = [
        "FiraCode" "DroidSansMono" "JetBrainsMono"
        "IntelOneMono" "Inconsolata" "AnonymousPro"
        "Noto"
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
  };
}
