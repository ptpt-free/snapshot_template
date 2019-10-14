# snapshot_template
## はじめに
- このリポジトリはスナップショットからGCEを作成するコードをまとめたリポジトリとなります。
- Google Cloud Shellでの利用を想定しています。

## 事前準備
リポジトリclone後、以下ファイルの設定項目を変更してください。  

variables.tf
| 変更箇所 | 変更内容 | 設定例 | 
|:--|:--|:--|
|【project】|デプロイする対象のプロジェクトID|sample_project|


deploy.tf
| 変更箇所 | 変更内容 | 設定例 | 
|:--|:--|:--|
|【SnapshotName】|作成しているスナップショットの名前|gce-snapshot|
|【ServiceAccount】|GCEをデプロイするためのサービスアカウント|sample@example.iam.gserviceaccount.com|


また、Terraformにデプロイするためのサービスアカウントを作成してください。  
ダウンロード後account.jsonと名前を変更しておいてください。


## 実行方法
Google Cloud Platformへログイン後、Cloud Shellを起動します。  
Terraformでデプロイする用のServiceAccountをアップロードします。

```
$ git clone https://github.com/ptpt-free/snapshot_template.git
$ cd snapshot_template
// 事前準備を適宜実行します。
// account.jsonを適宜修正します
$ terraform init
$ terraform plan
$ terraform apply
```
