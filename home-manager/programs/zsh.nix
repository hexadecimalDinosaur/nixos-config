{ secrets, pkgs, ... }:
{
  imports = [
    "${secrets}/home-manager/cli-extra.nix"
    # ./starship.nix
  ];

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "sudo"
        "git"
        "fzf"
      ];
      theme = "ys";
    };
    # zprof.enable = true;

    shellAliases = {
      v = "nvim";
      update = "sudo nix flake update nixos-config --flake /etc/nixos && sudo nixos-rebuild switch";
      hm-update = "home-manager switch";
      sudo = "sudo ";
      cat = "bat --plain --plain";
      nmap_shodan = /* sh */ "nmap --script shodan-api --script-args shodan-api.apikey=$(secret-tool lookup shodan shodan-api)";
      "nix-search-pkgs" = "nix search nixpkgs";
      git-root = /* sh */ "cd $(git rev-parse --show-toplevel)";
      manix-fzf = /* sh */ ''
        manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview="manix '{}'" | xargs manix
      '';
    };

    initExtra = /* bash */''
      export PATH=$HOME/.local/bin:$PATH
      export BROWSER="floorp"
      export VIRTUAL_ENV_DISABLE_PROMPT=1
      export UBXOPTS="-P 14" # U-blox 7 GPS receiver
      export PYTHONSTARTUP="$HOME/.pythonstartup"
      export HISTIGNORE="[ \t]*:ls:exit:pwd:clear:?:??:*tskey-client*"

      download_nixpkgs_cache_index () {
        filename="index-$(uname -m | sed 's/^arm64$/aarch64/')-$(uname | tr A-Z a-z)"
        mkdir -p ~/.cache/nix-index && cd ~/.cache/nix-index
        wget -q -N https://github.com/nix-community/nix-index-database/releases/latest/download/$filename
        ln -f $filename files
      }

      # for distrobox
      if lsb_release -d | grep "Ubuntu\|Debian" &> /dev/null; then
        alias bat="batcat"
        # alias secret-tool="distrobox-host-exec secret-tool"
      else
        eval "$(${pkgs.thefuck.out}/bin/thefuck --alias)"
        export BW_SESSION="$(${pkgs.libsecret}/bin/secret-tool lookup bw bw-session)"
      fi

      source "${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh"
      eval "$(${pkgs.nh}/bin/nh completions --shell zsh)"
      # source "${pkgs.colorls.out.gems.colorls.out}/lib/ruby/gems/${pkgs.colorls.ruby.version.libDir}/gems/${pkgs.colorls.name}/lib/tab_complete.sh"

      source "${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
    '';
  };
}
