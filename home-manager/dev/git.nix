{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      userName = "Ivy Fan-Chiang";
      userEmail = "dev@ivyfanchiang.ca";
      extraConfig = {
        commit = {
          gpgsign = true;
        };
        signing.signByDefault = true;
        delta.enable = true;
        push = {
          autoSetupRemote = true;
        };
      };
    };

    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-f
        gh-s
        gh-i
        gh-eco
        gh-poi
        gh-dash
        gh-notify
        gh-contribs
        gh-markdown-preview
      ];
    };
  };
}
