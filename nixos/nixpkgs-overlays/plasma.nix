final: prev:
{
  kdePackages = prev.kdePackages // {
    akonadi-calendar = prev.kdePackages.akonadi-calendar // {
      postInstall = ''
        rm $out/etc/xdg/autostart/org.kde.kalendarac.desktop
      '';
    };
  };
}
