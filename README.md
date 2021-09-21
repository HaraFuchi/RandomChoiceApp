## プロジェクト名
さいころdeごはん (RandomChoiceApp)

## 概要
過去に行った飲食店を登録し、サイコロボタンを押すと登録した飲食店の中からランダムで行き先を表示。また、過去に登録したお店を一覧画面で確認・編集・削除することが可能。

## 開発フロー
- チーム開発
- アジャイル開発

## 環境構築
1. リポジトリをclone
    -  `git clone https://github.com/HaraFuchi/RandomChoiceApp.git`
2. Bundlerをインストール
    -  `sudo gem install bundler`  
3. CocoaPodsをインストール
    -  `bundle install` 
4. CocoaPodsを実行
    -  `bundle exec pod install`  
5. Carthagoをインストール
    -  `brew install carthage`  
6. Carthagoを実行
    -  `XCODE_XCCONFIG_FILE=$PWD/Carthago.xcconfig
    carthage bootstrap --platform iOS --no-use-binaries --cache-builds`  
7. RandomChoiceApp.xcworkspace を開く  
8. Schemeを`Debugさいころdeごはん`に変更 ※RandomChoiceAppではありません

## タスク管理
issueを使用

## 開発情報

|  項目  |  バージョン  |
| :---: | :---: |
|  Xcode  |12.3|
|  Swift  | 5.3|
|  iOS  |  13.0以上  |
|  デバイス  |  iPhone<br>iPad<br>Mac(M1チップのみ) |
|  CocoaPods  |  1.10.0  |
|  SwiftLint  |  0.42.0  |

## 使用ライブラリ

**Firebase Authentication**  
簡単に認証機能を追加することができるライブラリ。本アプリでは匿名ログインを使用

**Firebase Realtime Database**  
Firebaseから提供されているNoSQLデータベース

## バージョン管理
GitHubを使用
- Git-flow に基づき運用

## デザインパターン
MVCモデルを使用

## ルール
### ブランチルール

|  ブランチ  | 役割  |
| :---: | --- |
|  master  |完成版のブランチ<br>基本的にここにコミットはしない<br>リリース単位のマージコミットが並ぶ|
|  release |リリースビルド作成用<br>もしバグが発生した場合は hotfixブランチを切って修正する|
|  hotfix/xxx  |  リリースビルド作成用後の修正ブランチ |
|  develop  |  開発用メインブランチ<br>デフォルトブランチ |
|  feature/xxx  |  機能開発用ブランチ |
|  fix/xxx  |  バグ修正用ブランチ  |

### コメントルール
TODO: リリースまでに完了させたい修正箇所  
FIXME: 長期化の可能性がある修正箇所  

## 環境構築
1. Bundlerをインストール
    -  `sudo gem install bundler` 
2. リポジトリをclone
    -  `git clone https://github.com/HaraFuchi/RandomChoiceApp.git` 
3. CocoaPodsをインストール
    -  `bundle install` 
4. CocoaPodsを実行
    -  `bundle exec pod install`  
5. RandomChoiceApp.xcworkspace を開く  
6. Schemeを`Debugさいころdeごはん`に変更 ※RandomChoiceAppではありません

## インストール
[さいころdeごはん(App Store)](https://apps.apple.com/jp/app/%E3%81%95%E3%81%84%E3%81%93%E3%82%8Dde%E3%81%94%E3%81%AF%E3%82%93/id1528912786)

## 開発者
harafuchi0324@gmail.com  
