let
  pkgs = import <nixpkgs> {};
in  
with pkgs;
stdenv.mkDerivation rec {
  pname = "volatility2-bin";
  version = "2.6.1";

  src = fetchzip {
    url = "https://github.com/volatilityfoundation/volatility/releases/download/2.6.1/volatility_2.6_lin64_standalone.zip";
    stripRoot = true;
    hash = "sha256-ucG6oR4gBRUjMmHRr9QNenc04ENvwLvyCzSAqIoAiwM=";
  };

  dontConfigure = true;
  dontBuild = true;

  buildInputs = [
    zlib
    libz
  ];

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  installPhase = ''
    install $src/volatility_2.6_lin64_standalone -m 555 -p -D -T $out/bin/volatility2
    ln -s $out/bin/volatility2 $out/vol2
  '';

  meta = with lib; {
    homepage = "https://volatilityfoundation.org/";
    mainProgram = "volatility2";
    description = "An advanced memory forensics framework";
    platforms = platforms.linux;
    architectures = [ "amd64" ];
    maintainers = with lib.maintainers; [ ivyfanchiang ];
    license = lib.licenses.gpl2;
  };
}
