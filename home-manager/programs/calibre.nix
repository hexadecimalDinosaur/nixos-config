{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ( calibre.overrideAttrs (finalAttrs: prevAttrs: {
      preFixup = (
        builtins.replaceStrings
          [
            ''
              wrapProgram $program \
            ''
          ]
          [
            ''
              wrapProgram $program \
                --prefix LD_LIBRARY_PATH : ${pkgs.openssl.out}/lib \
            ''
          ]
          prevAttrs.preFixup
      );
    }))
  ];
}
