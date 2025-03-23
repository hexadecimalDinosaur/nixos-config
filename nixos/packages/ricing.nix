{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # icons
    kdePackages.oxygen-icons
    kdePackages.breeze-icons
    humanity-icon-theme
    catppuccin-papirus-folders
    vimix-icon-theme
    qogir-icon-theme
    whitesur-icon-theme
    nordzy-icon-theme
    # cursor themes
    material-cursors
    vimix-cursors
    bibata-cursors
    bibata-cursors-translucent
    breeze-hacked-cursor-theme
    capitaine-cursors
    whitesur-gtk-theme
    catppuccin-cursors
    # gtk themes
    yaru-theme
    materia-theme-transparent
    layan-gtk-theme
    tokyonight-gtk-theme
    qogir-theme
    whitesur-cursors
    # plasma/qt themes
    materia-kde-theme
    kdePackages.oxygen
    kdePackages.breeze
    lightly-qt
    whitesur-kde
    qogir-kde
    (catppuccin-kde.override {
      flavour = [ "mocha" "macchiato" "frappe" "latte" ];
      accents = [ "lavender" "sapphire" "rosewater" "teal" ];
    })
    # plasma addons
      #unstable.kdePackages.sierra-breeze-enhanced
    unstable.kdePackages.karousel
    unstable.kdePackages.applet-window-buttons6
    # sounds
    kdePackages.oxygen-sounds
    pantheon.elementary-sound-theme
    lomiri.lomiri-sounds
  ];
}
