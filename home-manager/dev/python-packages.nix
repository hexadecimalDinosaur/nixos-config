{ config, ... }:
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

    # online apis
    datadog
    hetzner
    boto3
  ];
}
