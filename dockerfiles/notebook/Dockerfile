# GDAL公式イメージをベースとして使用
FROM ghcr.io/osgeo/gdal:ubuntu-small-latest

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo "Acquire::http::Pipeline-Depth 0;" > /etc/apt/apt.conf.d/99custom && \
    echo "Acquire::http::No-Cache true;" >> /etc/apt/apt.conf.d/99custom && \
    echo "Acquire::BrokenProxy    true;" >> /etc/apt/apt.conf.d/99custom && \
    echo 'Acquire::http::Timeout "300";' > /etc/apt/apt.conf.d/99timeout

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    python3-pip \ 
    python3.12-venv \
    fonts-noto-cjk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /app

# 必要なPythonパッケージをインストール
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
#RUN pip3 install --no-cache-dir \
#    jupyter \
#    geopandas \
#    osmnx \
#    contextily \
#    scikit-learn \
#    matplotlib \
#    japanize-matplotlib \
#    folium

COPY src/notebook/requirements.txt /tmp/requirements.txt
RUN set -ex && \
    pip3 install --upgrade pip && \
    pip3 install -r /tmp/requirements.txt && \
    rm -rf /root/.cache/

# Jupyter Notebookの設定
EXPOSE 8888
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

