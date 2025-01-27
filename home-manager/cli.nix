{ pkgs, ... }:
{
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
      honepot-ssh = "knock -v REDACTED -d 500 && ssh honeypot";
      nmap_shodan = "nmap --script shodan-api --script-args shodan-api.apikey=$(secret-tool lookup shodan shodan-api)";
      # cs246
      "g++20m" = "g++-11 -std=c++20 -fmodules-ts -Wall -g";
      "g++20h" = "g++-11 -std=c++20 -fmodules-ts -c -x c++-system-header";
      "g++20i" = "g++-11 -std=c++20 -Wall -g";
      "nix-search-pkgs" = "nix --extra-experimental-features 'nix-command flakes' search nixpkgs";
      git-root = "cd $(git rev-parse --show-toplevel)";
    };
    localVariables = {
      UBXOPTS = "-P 14";
    };
    initExtra = ''
      uwldapsearch() {
        ldapsearch -x -b "dc=uwaterloo,dc=ca" -H ldap://uwldap.uwaterloo.ca "(&(objectclass=person)(objectClass=inetLocalMailRecipient)(displayName=*$1*))"
      }
      export PATH=$HOME/.local/bin:$PATH
      if lsb_release -d | grep "Ubuntu\|Debian" &> /dev/null; then
        alias bat="batcat"
      else
        eval $(thefuck --alias)
      fi
      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
    '';
  };
  programs.git = {
    enable = true;
    userName = "Ivy Fan-Chiang";
    userEmail = "dev@ivyfanchiang.ca";
    extraConfig = {
      commit = {
        gpgsign = true;
      };
      user = {
        signingkey = "38FB5AF70FFA291D6809B85D37664215B5B9EE1C";
      };
      push = {
        autoSetupRemote = true;
      };
    };
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
