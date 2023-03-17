vimの設定
============================================================

毎回設定が非常に面倒なため、自分の環境用のvimの設定を記載する。

Ubuntu環境の場合は、`docker compose up` を実行すると、次のようなエラーになる場合がある。

```
The name org.freedesktop.secrets was not provided by any .service files
```

恐らく、 `gnome-keyring` がインストールされていないと思われるので、次のコマンドを実行してインストールすること。

```
sudo apt install gnome-keyring
```
