{ pkgs, ... }:
let
  fzf-tab-completion = (pkgs.callPackage ./../custom-pkgs/fzf-tab-completion.nix { });
in
{
  py3Pkgs = ps: with ps; [
    # web
    requests
    flask
    fastapi
    django
    beautifulsoup4
    websockets

    # databases
    sqlalchemy

    # data sci/math
    pandas
    numpy
    sympy

    # jupyter
    ipython
    rich
    jupyter
    matplotlib
    qtconsole

    # file formats
    pillow
    xlsxwriter
    av
    imageio-ffmpeg

    # computation
    z3

    # online apis
    datadog
    hetzner
    boto3

    # dev tools
    black
    autopep8
    pytest
    isort
    flake8
    mypy
    ptpython
  ];
  home = {
    file.".pythonstartup" = {
      text = /* python */ ''
        from rich import pretty, traceback, inspect
        pretty.install()
        traceback.install(show_locals=True)
        del pretty
        del traceback
        with open('${fzf-tab-completion}/python/fzf_python_completion.py', 'r') as f:
            exec(f.read())
      '';
    };
    sessionPath = [
      "${fzf-tab-completion}/python"
    ];
  };

  home.packages = [
    pkgs.pyright
    fzf-tab-completion
  ];
}
