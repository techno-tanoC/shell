1. `https://bitwarden.com/` からAppImageファイルをダウンロード
2. ダウンロードしたバイナリに実行権限を付ける
3. desktop entryを作成

```~/.local/share/applications/bitwarden.desktop
[Desktop Entry]
Name=Bitwarden
Exec=bitwarden
Terminal=false
Type=Application
Icon=bitwarden.jpg
```

パスの通ってない場所に置いた場合は絶対パスで指定する。

アイコンを置く場所は以下を参照。
https://specifications.freedesktop.org/icon-theme-spec/icon-theme-spec-latest.html
