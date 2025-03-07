{ pkgs, lib, config, ... }:
let
  pyPkgList = lib.mkOptionType {
    name = "pymods";
    merge = _: defs: map (def: def.value) defs;
  };
  fzf-tab-completion = (pkgs.callPackage ./../custom-pkgs/fzf-tab-completion.nix { });
in
{
  options = {
    py3Pkgs = lib.mkOption {
      type = pyPkgList;
      default = _: [ ];
    };
  };
  config = {
    py3Pkgs = ps: with ps; [
      # web utilities
      requests
      websockets
      beautifulsoup4

      # databases
      sqlalchemy

      # flask
      flask
      flask-sqlalchemy
      flask-sock
      jinja2

      # fastapi
      fastapi
      fastapi-cli

      # otel
      opentelemetry-api
      opentelemetry-sdk
      opentelemetry-instrumentation-fastapi

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
      jupyterlab-lsp

      # file formats
      pillow
      xlsxwriter
      av
      imageio-ffmpeg

      # computation
      z3
      pycrypto
      pycryptodome

      # online apis
      datadog
      hetzner
      boto3

      # dev tools
      black
      isort
      ptpython
      pydevd

      # integrations
      pynvim

      # lsp
      python-lsp-server
      pylsp-rope
      python-lsp-ruff
      yapf
      pycodestyle
      mccabe
      pyflakes
      flake8
      autopep8

      # pytest
      pytest

      # mypy
      mypy
      mypy-extensions
      pylsp-mypy
      pytest-mypy-plugins
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
      pkgs.nbqa
      pkgs.djhtml
      fzf-tab-completion
      (pkgs.python312.withPackages (
        ps: builtins.concatMap (f: f ps) config.py3Pkgs
      ))
    ];
  };
}
