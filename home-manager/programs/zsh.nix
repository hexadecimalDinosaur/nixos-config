{ secrets, pkgs, ... }:
{
  imports = [
    "${secrets}/home-manager/cli-extra.nix"
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
      update = "sudo nix flake update nixos-config --flake /etc/nixos && sudo nixos-rebuild switch";
      hm-update = "home-manager switch";
      sudo = "sudo ";
      cat = "bat --plain --plain";
      nmap_shodan = /* sh */ "nmap --script shodan-api --script-args shodan-api.apikey=$(secret-tool lookup shodan shodan-api)";
      "nix-search-pkgs" = "nix search nixpkgs";
      git-root = /* sh */ "cd $(git rev-parse --show-toplevel)";
    };

    initExtra = /* bash */''
      export PATH=$HOME/.local/bin:$PATH
      export BROWSER="floorp"

      export UBXOPTS="-P 14" # U-blox 7 GPS receiver
      export PYTHONSTARTUP="$HOME/.pythonstartup"
      export BW_SESSION="$(secret-tool lookup bw bw-session)"

      download_nixpkgs_cache_index () {
        filename="index-$(uname -m | sed 's/^arm64$/aarch64/')-$(uname | tr A-Z a-z)"
        mkdir -p ~/.cache/nix-index && cd ~/.cache/nix-index
        # -N will only download a new version if there is an update.
        wget -q -N https://github.com/nix-community/nix-index-database/releases/latest/download/$filename
        ln -f $filename files
      }

      # for distrobox
      if lsb_release -d | grep "Ubuntu\|Debian" &> /dev/null; then
        alias bat="batcat"
        alias secret-tool="distrobox-host-exec secret-tool"
      else
        eval $(thefuck --alias)
      fi

      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

      autoload -U compinit; compinit
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    '';
  };
}
