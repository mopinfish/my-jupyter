FROM jupyter/datascience-notebook:python-3.11.5
#FROM jupyter/datascience-notebook:d53a302fbcd0
USER root
ENV DEBCONF_NOWARNINGS yes

# 最新のpostgresqlへの対応を行っている (参考: https://www.postgresql.org/download/linux/ubuntu/ )
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo "Acquire::http::Pipeline-Depth 0;" > /etc/apt/apt.conf.d/99custom && \
    echo "Acquire::http::No-Cache true;" >> /etc/apt/apt.conf.d/99custom && \
    echo "Acquire::BrokenProxy    true;" >> /etc/apt/apt.conf.d/99custom

# for GDAL
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update && apt-get install -y libgdal-dev
#RUN pip install GDAL==$(gdal-config --version) --global-option=build_ext --global-option="-I/usr/include/gdal"

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends lsb-release gnupg \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /usr/share/keyrings/postgres-archive-keyring.gpg \
    && sh -c 'echo "deb [signed-by=/usr/share/keyrings/postgres-archive-keyring.gpg] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && apt-get update \
    && apt-get install -y --no-install-recommends gdal-bin libgdal-dev \
    && apt-get install -y --no-install-recommends libxml2-dev libxslt-dev \
    && apt-get remove -y lsb-release gnupg \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /opt/julia-*/share/julia/stdlib/v*/SuiteSparse/.devcontainer/Dockerfile /opt/julia/packages/Pluto/*/.vscode/ \
    && find / -type f -perm /u+s -ignore_readdir_race -exec chmod u-s {} \; \
    && find / -type f -perm /g+s -ignore_readdir_race -exec chmod g-s {} \;

#RUN chown -R jovyan:users /home/jovyan
USER jovyan
WORKDIR /home/jovyan
COPY /src/notebook/Pipfile .
COPY /src/notebook/Pipfile.lock .

# hadolint ignore=SC2016
RUN pip3 install --no-cache-dir pipenv==2024.4.0 \
    # pipenvを使用してrasterioをインストールする前に、GDALのPythonバインディングをインストール
    && pipenv install --system --ignore-pipfile --deploy
#    && pipenv install --system --ignore-pipfile --deploy \
#    && rm -rf Pipfile* .cache/R/pkgcache/sysreqs/docker/*/Dockerfile /tmp/* /var/tmp/*

HEALTHCHECK --interval=5s --retries=20 CMD ["curl", "-s", "-S", "-o", "/dev/null", "http://localhost:8888"]
