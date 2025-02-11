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
    # gtk themes
    yaru-theme
    materia-theme
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
    # plasma addons
    kdePackages.sierra-breeze-enhanced
    kdePackages.karousel
    kdePackages.applet-window-buttons6
    material-kwin-decoration
    sierra-breeze-enhanced
    # sounds
    kdePackages.oxygen-sounds
    pantheon.elementary-sound-theme
    lomiri.lomiri-sounds
  ];
}
