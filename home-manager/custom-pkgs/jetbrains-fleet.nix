{
  lib,
  stdenv,
  fetchzip,
  autoPatchelfHook,
  makeWrapper,
  makeDesktopItem,

  jetbrains,
  fontconfig,
  libgcc,
  xorg,
  libGL,
  alsa-lib,
  wayland
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "jetbrains-fleet";
  version = "1.45.163";

  src = fetchzip {
    url = "https://download-cdn.jetbrains.com/fleet/installers/linux_x64/Fleet-${finalAttrs.version}.tar.gz";
    hash = "sha256-lfIXlZv+tOdtT97BXga5SremZN+G56UBwHEP7nbqse0=";
    stripRoot = true;
  };

  dontConfigure = true;
  dontBuild = true;
  dontStrip = true;

  buildInputs = [
    jetbrains.jdk
    libgcc
    fontconfig
    xorg.libX11
    xorg.libXi
    xorg.libXtst
    xorg.libXrender
    stdenv.cc.cc
    libGL
    alsa-lib
    wayland
  ];

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/fleet
    cp -r $src/bin $out/fleet
    mkdir -p $out/fleet/lib
    cp -r $src/lib/app $out/fleet/lib/app
    cp -r $src/lib/runtime $out/fleet/lib/runtime
    cp $src/lib/Fleet.png $out/fleet/lib/Fleet.png
    cp $src/lib/cds.png $out/fleet/lib/cds.png
    cp $src/lib/classList.png $out/fleet/lib/classList.png
    cp $src/lib/libapplauncher.so $out/fleet/lib/libapplauncher.so
    cp -r $src/license $out/fleet/license

    mkdir $out/bin
    makeWrapper $out/fleet/bin/Fleet $out/bin/fleet

    mkdir -p $out/share/icons/hicolor/1024x1024/apps
    cp $src/lib/Fleet.png $out/share/icons/hicolor/1024x1024/apps/jetbrains-fleet.png

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = finalAttrs.pname;
      desktopName = "JetBrains Fleet";
      exec = "fleet";
      icon = "jetbrains-fleet";
      genericName = finalAttrs.meta.description;
      comment = finalAttrs.meta.longDescription;
      categories = [ "Development" ];
    })
  ];

  meta = {
    description = "More Than a Code Editor";
    longDescription = "Fleet is a code editor designed for simplicity, combining a clean UI, AI capabilities, and an essential set of built-in features for most major languages.";
    mainProgram = "fleet";
    homepage = "https://www.jetbrains.com/fleet/";
    license = lib.licenses.unfree;
    maintainers = [ lib.maintainers.ivyfanchiang ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    changelog = "https://www.jetbrains.com/help/fleet/${lib.versions.majorMinor finalAttrs.version}/release-notes-fleet.html";
  };
})
