{ pkgs, ... }:
{
  imports = [
    ./secrets/cli-extra.nix
  ];

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "sudo"
        "git"
        "fzf"
        "direnv"
      ];
      theme = "ys";
    };
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      update = "sudo nixos-rebuild switch";
      hm-update = "home-manager switch";
      sudo = "sudo ";
      cat = "bat --plain --plain";
      codi = ''
        nvim -c \
          "let g:startify_disable_at_vimenter = 1 |\
          set bt=nofile ls=0 noru nonu nornu |\
          hi ColorColumn ctermbg=NONE |\
          hi VertSplit ctermbg=NONE |\
          hi NonText ctermfg=0 |\
          Codi python"
      '';
      nmap_shodan = "nmap --script shodan-api --script-args shodan-api.apikey=$(secret-tool lookup shodan shodan-api)";
      "nix-search-pkgs" = "nix search nixpkgs";
      git-root = "cd $(git rev-parse --show-toplevel)";
    };
    localVariables = {
      UBXOPTS = "-P 14";  # U-blox 7 GPS receiver
    };
    initExtra = ''
      export PATH=$HOME/.local/bin:$PATH
      export BW_SESSION="$(secret-tool lookup bw bw-session)"

      # for distrobox
      if lsb_release -d | grep "Ubuntu\|Debian" &> /dev/null; then
        alias bat="batcat"
      else
        eval $(thefuck --alias)
      fi

      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

      autoload -U compinit; compinit
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    '';
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  home.file = {
    ".local/bin/syscat" = {
      source = scripts/syscat;
      executable = true;
    };
  };
}
