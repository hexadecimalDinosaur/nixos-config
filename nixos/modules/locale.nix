{ pkgs, config, ... }:
{
  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_CA.UTF-8";
    LC_IDENTIFICATION = "en_CA.UTF-8";
    LC_MEASUREMENT = "en_CA.UTF-8";
    LC_MONETARY = "en_CA.UTF-8";
    LC_NAME = "en_CA.UTF-8";
    LC_NUMERIC = "en_CA.UTF-8";
    LC_PAPER = "en_CA.UTF-8";
    LC_TELEPHONE = "en_CA.UTF-8";
    LC_TIME = "en_CA.UTF-8";
  };

   i18n.inputMethod = {
     type = "fcitx5";
     enable = true;
     fcitx5 = {
       waylandFrontend = true;
       plasma6Support = true;
       addons = with pkgs; [
         fcitx5-gtk
         fcitx5-chinese-addons
         fcitx5-nord
         fcitx5-pinyin-zhwiki
         fcitx5-fluent
         fcitx5-chewing
         fcitx5-tokyonight
         catppuccin-fcitx5
       ];
     };
   };

  environment.systemPackages = with pkgs; [
    # spell check
    hunspell
    hunspellDicts.en_CA
    hunspellDicts.en_US
    hunspellDicts.en_CA-large
    hunspellDicts.fr-any
    aspell
    aspellDicts.en
    aspellDicts.en-science
    aspellDicts.en-computers
    aspellDicts.fr
  ];
}
