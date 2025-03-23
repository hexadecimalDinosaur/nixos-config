{ lib, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 1300;
      scan_timeout = 50;
      format = ''
        $username$localip$hostname$directory$git_state$git_branch$git_commit$status'';

      status = { format = "C:[$code]($style)"; };
      username = { format = "[$user]($style) at"; style_user = "dimmed blue"; };
      hostname = { style = "dimmed green"; };
      directory = { style = "dimmed cyan"; read_only_style = "dimmed red"; };
      git_branch = { style = "dimmed purple"; };
      git_commit = { style = "dimmed purple"; tag_disabled = false; };
      git_state = { style = "bold orange"; };
    };
  };
}
