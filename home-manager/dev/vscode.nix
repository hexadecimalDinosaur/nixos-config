{ unstable }: { pkgs, ... }:
{
  home.packages = with unstable; [
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        # infra
        tailscale.vscode-tailscale
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        ms-vscode-remote.remote-containers
        ms-azuretools.vscode-docker

        # nix
        bbenoist.nix
        arrterian.nix-env-selector
        mkhl.direnv
        brettm12345.nixfmt-vscode

        # python
        ms-python.python
        ms-pyright.pyright
          # ms-python.vscode-python-envs
        ms-toolsai.jupyter
        ms-python.isort
        ms-python.black-formatter
          # ms-python.autopep8

        # c++
        ms-vscode.cpptools-extension-pack

        # java
        vscjava.vscode-java-pack
        redhat.java

        # go
        golang.go

        # themes
        enkia.tokyo-night

        # dev tools
        formulahendry.code-runner
        eamodio.gitlens
        esbenp.prettier-vscode
        ms-vscode.hexeditor

        # writing
        yzhang.markdown-all-in-one
        tomoki1207.pdf
        redhat.vscode-yaml

        # dendron
        dendron.dendron
        dendron.dendron-markdown-preview-enhanced
        dendron.dendron-paste-image
        dendron.dendron-snippet-maker
        dendron.adjust-heading-level
      ];
    })
  ];
}
