{ pkgs, ... }:
{
  environment = {
    plasma6.excludePackages = with pkgs; [
      kdePackages.kdepim-runtime
      kdePackages.akonadi-calendar
    ];

    systemPackages = with pkgs; [
      # office
      kdePackages.okular
      kdePackages.kcalc
      # edu
      kstars
      crow-translate
      # media
      kdePackages.plasmatube
      kdePackages.krecorder
      kdePackages.kasts
      kdePackages.kdenlive
      # games
      kdePackages.kigo
      kdePackages.kmines
      kdePackages.kpat
      kdePackages.ksudoku
      kdePackages.kreversi
      # plasma settings
      kdePackages.plasma-workspace-wallpapers
      kdePackages.kgamma
      # plasma integrations
      kdePackages.plasma-browser-integration
      kdePackages.kdeconnect-kde
      kdePackages.dolphin-plugins
      # plasma utils
      kdePackages.kdeplasma-addons
      kdePackages.partitionmanager
      kdePackages.kweather
      kdePackages.filelight
      kdePackages.ktorrent
      kdePackages.kruler
      kdePackages.kget
      kdePackages.keysmith
      kdePackages.kcolorchooser
      kdePackages.kclock
      kdePackages.ksystemlog
      # dev
      kdePackages.yakuake
      kdePackages.kate
      kdePackages.kleopatra
      kdePackages.kdialog
      kdePackages.kdesu
      # kio
      kdePackages.kio-zeroconf
      kdePackages.kio-gdrive
      # # kontact/akonadi apps
      # kdePackages.kontact
      # kdePackages.kaddressbook
      # kdePackages.kmail
      # kdePackages.merkuro
      # # akonadi - kmail
      # kdePackages.kmailtransport
      # kdePackages.kmail-account-wizard
      # # akonadi - plugins/lib
      # kdePackages.pim-data-exporter
      # kdePackages.akonadi-import-wizard
      # kdePackages.akonadi-search
      # kdePackages.libkdepim
      # kdePackages.kdepim-addons
      # kdePackages.kdepim-runtime
      # kdePackages.akonadi
      # kdePackages.ktexttemplate
      # kdePackages.grantleetheme
      # kdePackages.akonadi-mime
      # kdePackages.messagelib
      # kdePackages.mbox-importer
      # grantlee
      # kdePackages.akonadiconsole
      # # akonadi - kalendar/merkuro
      # kdePackages.calendarsupport
      # kdePackages.akonadi-calendar-tools
      # kdePackages.kcalendarcore
      # kdePackages.kcalutils
      # kdePackages.kldap
      # # akonadi - contacts
      # kdePackages.akonadi-contacts
    ];
  };
}
