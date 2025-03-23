{ stdenv, glib, libglvnd, xorg, fontconfig, dbus, autoPatchelfHook, fetchzip
, wayland, qt6, zlib, makeDesktopItem, python3, lib, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "binaryninja";
  version = "4.3.6898-dev";
  description = "Binary Ninja: A Reverse Engineering Platform";

  src = fetchzip {
    url = "https://nc.ivyfanchiang.ca/s/tE7Sxd8CaWHZeeH/download?path=%2F&files=binaryninja_linux_dev_personal.zip";
    hash = "sha256-064Q+39UQpQzwrgQr8FbODnaQA0TRJyOJ0wyo/vYs+c=";
  };

  desktop = makeDesktopItem {
    name = "Binary Ninja Personal";
    exec = "binaryninja";
    icon = pname;
    comment = description;
    desktopName = "Binary Ninja Personal";
    categories = [ "Utility" ];
  };

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/icons
    mkdir -p $python/lib/python3.12/site-packages/
    cp -r $src/* $out
    mv $out/docs $out/binaryninja-docs

    ln -s $out/binaryninja $out/bin/binaryninja
    ln -s $out/binaryninja-docs/img/logo.png $out/share/icons/binaryninja.png
    ln -s "$desktop/share/applications" $out/share/
    ln -s $out/python/binaryninja $python/lib/python3.12/site-packages/binaryninja
  '';

  postFixup = ''
    wrapProgram $out/bin/binaryninja --prefix LD_LIBRARY_PATH : ${
      lib.makeLibraryPath [ python3 ]
    }
  '';

  dontWrapQtApps = true;

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];
  buildInputs = [
    stdenv.cc.cc
    glib # libglib-2.0.so.0
    fontconfig # libfontconfig.so.1
    dbus # libdbus-1.so.3
    libglvnd # libGL.so.1
    xorg.libX11 # libX11.so.6
    xorg.libXi # libXi.so.6
    xorg.libXrender # libXrender.so.1
    wayland # libwayland.so.0
    qt6.qtbase # Everything Qt6
    zlib # libz.so.1
    stdenv.cc.cc.lib # libstdc++.so.6
    (qt6.qtdeclarative.overrideAttrs (finalAttrs: previousAttrs: {
      # libQt6Qml.so.6 / libQt6QuickVectorImageGenerator.so.6
      propagatedBuildInputs = previousAttrs.propagatedBuildInputs ++ [qt6.qtsvg];
    }))
    qt6.qtwayland # libQt6WaylandClient.so.6
  ];
  runtimeDependencies = [
    python3 # libpython.so
    qt6.qtwayland
    qt6.qtbase
    xorg.libX11
    xorg.libXi
    xorg.libXrender
  ];
  outputs = [
    "out"
    "python"
  ];
  meta = {
    homepage = "https://binary.ninja/";
    description = description;
    platforms = [ "x86_64-linux" ];
    maintainers = [ "Thea Heinen <theinen@protonmail.com>" ];
    broken = false;
  };
}
