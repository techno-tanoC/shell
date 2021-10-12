## Apps
## Bitwarden
https://bitwarden.com/download/

- snapでインストールすると起動が遅い

## Insomnia
https://insomnia.rest/download

- snapでインストールすると起動が遅い

## Slack
https://slack.com/intl/ja-jp/downloads/linux

- snapでインストールすると日本語入力できない

## Code
https://code.visualstudio.com/download

## Discord
https://discord.com/download

## ngrok
https://ngrok.com/download

### Book viewer
calibre

### adb
android-tools android-udev

### Movie editor
kenlive

### CD ripper

```
yay -S cdrdao
yay -S cdemu-client linux56-vhba-module
```

```
cdrdao read-cd --read-raw --datafile 'TITLE'.{bin,toc}
```

### ssh-copy-id
`ssh-copy-id user@ip-address`

## linux
### アラート音( firefox含む )を消したい
`dconf-editor` を入れて `org/gnome/desktop/sound/event-sounds` を `False` にする
https://ubuntuhandbook.org/index.php/2019/03/disable-mute-alert-sound-ubuntu-19-04/

### キーボード周り

- fcitxインストール後にキーボードレイアウトがおかしい時はfcitx-settinのキーボードが日本語になっているか確認
- loadkeys jp106

- "設定"がない時は`pacman -S gnome-control-center`

### 問題報告
設定->プライバシー->診断で変更できる

### mozcの辞書ツール
`/usr/lib/mozc/mozc_tool --mode=dictionary_tool`

### manjaro linux に nvidia のドライバを入れる
https://wiki.manjaro.org/index.php?title=Configure_NVIDIA_(non-free)_settings_and_load_them_on_Startup
sudo mhwd -a pci nonfree 0300

### ubuntu 20.04 に nvidia のドライバを入れる
- `ubuntu-drivers devices` で推奨ドライバを確認
- `sudo apt install nvidia-driver-450` でドライバをインストール
- 再起動する
- `nvidia-smi` で動作確認

事前に nouveau を無効化しないといけないかも
https://www.server-world.info/query?os=Ubuntu_20.04&p=nvidia&f=1

### スピーカーの音量が大きすぎる
https://chrisjean.com/fix-for-usb-audio-is-too-loud-and-mutes-at-low-volume-in-ubuntu/

## firefox
### ホイールの横クリックの移動量を変える
about:config -> mousewheel.default.delta_multiplier_x

### URLバーをクリックした時に全て選択する
browser.urlbar.clickSelectsAll
