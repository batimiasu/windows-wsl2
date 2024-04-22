# windows-wsl2
Mac -> Windows(WSL2) に SSH 接続して VSCode Remote Development を実現するための便利スクリプト集

## 前提
- Windows に WSL2 をインストールしていること

## 設定手順
1. [Remote Development using SSH](https://code.visualstudio.com/docs/remote/ssh) に従って VScode をセットアップする
2. `get_ipv4.bash`　を WSL ユーザーのホームディレクトリに配置する
3. `portforwarding.ps1` を編集して $HOST_IPV4 に　Windows の IP アドレスを指定する
4. PowerShell で `portforwarding.ps1` を実行して Windows から WSL2 へポートフォワードする
5. `wsl2_ssh_restart.bat`　を実行して WSL2 の sshd を起動する


## Tips
- Mac から WSL2 で立ち上げているサービスにアクセスできない場合、WSL2 のファイアウォールにブロックされている可能性がある。powershell から以下を実行して任意のポート指定してを許可する（以下は22番ポートを許可する例）
```powershell
New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Inbound -LocalPort 22 -Action Allow -Protocol TCP
New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Outbound -LocalPort 22 -Action Allow -Protocol TCP
```
- Windows または WSL2 を再起動すると WSL2 の IP アドレスが変わってしまうのでポートフォワーディングを再設定する必要がある。Windows のタスクスケジューラなどで起動後に `portforwardning.ps1` を実行すると良さそう。
- 　WSL2 をアップデートするとファイアウォールの設定もリセットされるので再設定する。
- 同様に WSL2 の sshd も自動起動しないので `wsl2_ssh_restart.bat` を起動後に実行すると良さそう。
- VSCode の PlayStation Managed Debugger Extension は使えなさそう？
