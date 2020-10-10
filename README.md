# プロジェクト名

さいころdeごはん (RandomChoiceApp)

# 概要
過去に行った飲食店を登録し、サイコロボタンを押すと登録した飲食店の中からランダムで行き先を表示。また、過去に登録したお店を一覧画面で確認・編集・削除することが可能。

# 開発フロー
- チーム開発
- アジャイル開発

# タスク管理
タスク管理ツールTrelloを使用

# 開発情報
- 開発環境: Xcode ( V12.0.1 )
- 使用言語: Swift (V5.3)
- 対応デバイス: iPhone, iPad (サポート対象: iOS13.0〜)
- CocoaPods (V1.9.1)

# 使用ライブラリ
- Firebase Authentication 
簡単に認証機能を追加することができるライブラリ。本アプリでは匿名ログインを使用

- Firebase Realtime 
Database Firebaseから提供されているNoSQLデータベース

# バージョン管理
GitHubを使用

# ブランチルール
- master: リリースブランチ  
基本的にここにコミットはしない  
リリース単位のマージコミットが並ぶ

- develop: 開発ブランチ  
トピックブランチのマージコミットが並ぶ

- トピックブランチ  
feature/xxxxx: 機能  
hotfix/xxxxx: 不具合修正  
refactor/xxxxx: リファクタリング  

# インストール
`$ git clone https://github.com/HaraFuchi/RandomChoiceApp.git`

# 作者
harafuchi0324@gmail.com  
