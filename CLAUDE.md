# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

地理空間データサイエンスと都市分析のための個人用Jupyter Lab環境。GIS、機械学習、統計分析用のPythonパッケージがプリインストールされたJupyterLabをDockerで実行する。

## 主要コマンド

### Docker操作
```bash
# JupyterLabをビルドして起動
docker compose build
docker compose up

# http://localhost:8888 でアクセス（トークン不要）
```

### 依存関係の管理
```bash
# src/notebook/Pipfile変更後にPipfile.lockを更新
make update_piplock

# コンテナからPipfile/Pipfile.lockをローカルにコピー
make cp_pipfiles_to_local

# 現在のpipパッケージをrequirements.txtにエクスポート
make freeze
```

### Gitサブモジュール管理
```bash
# 新しいサブモジュールを追加（他リポジトリのノートブック/サンプル）
make addsubmodule REPO=<git-url> DIR=<dirname>

# サブモジュールを削除
make removesubmodule DIR=<dirname>
```

## アーキテクチャ

- **dockerfiles/notebook/Dockerfile**: GDAL Ubuntuイメージベース、`src/notebook/requirements.txt`からPythonパッケージをインストール
- **docker-compose.yml**: JupyterLabサービス設定（メモリ上限15GB）、`docker/work`を`/app/work`にマウント
- **src/notebook/**: Python依存関係のPipfileとrequirements.txt（GIS、ML、ベイズ統計）
- **docker/work/submodules/**: 各種GIS/都市分析コースのサンプルノートブックを含むGitサブモジュール（ppd534、ppd599、ppde642、osmnx-examplesなど）

## Python環境

主要パッケージ: osmnx、geopandas、folium、contextily、pymc、arviz、scikit-learn、rasterio、japanize-matplotlib。依存関係はPipfileで管理し、Dockerイメージではrequirements.txtからインストール。
