{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        ms-python.python
        ms-pyright.pyright
        ms-azuretools.vscode-docker
        enkia.tokyo-night
        formulahendry.code-runner
        eamodio.gitlens
        vscjava.vscode-java-pack
        golang.go
        ms-vscode.cpptools
        bbenoist.nix
        esbenp.prettier-vscode
        tomoki1207.pdf
        yzhang.markdown-all-in-one
        mkhl.direnv
        tailscale.vscode-tailscale
        # dendron.dendron
        # dendron.dendron-paste-image
        # dendron.dendron-markdown-preview-enhanced
      ];
    })
  ];
}
