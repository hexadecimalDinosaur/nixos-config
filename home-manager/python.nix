{ config, pkgs, ... }:
{
  home.packages = with pkgs.python311Packages; [
    pwntools
    pandas
    numpy
    sympy
    flask
    fastapi
    django
    sqlalchemy
    matplotlib
    jupyter
    qtconsole
    beautifulsoup4
    pillow
    requests
    websockets
    datadog
    ipython
    rich
    shodan
  ];
}
