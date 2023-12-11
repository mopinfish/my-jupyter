
## 作業ログ

### Pythonバージョンの更新

1. 参考にした100-knockのリポジトリからPipfileおよびPipfile.lockをコピー。その際にPipfileの差分ライブラリを控えておく
2. dockerをbuildおよびdocker compose upを行う
3. 差分のライブラリをPipfileに奇術師、make update_pipfileにてPipfile.lockを更新
4. リポジトリの変更をコミット、プッシュする
