final: prev:
{
  kdePackages = prev.kdePackages // {
    akonadi-calendar = prev.kdePackages.akonadi-calendar.overrideAttrs (finalAttrs: prevAttrs: {
      postInstall = ''
        rm $out/etc/xdg/autostart/org.kde.kalendarac.desktop
      '';
    });
  };
}
