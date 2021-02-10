//
//  Constrains.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/30.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

/**********************************************************************/
// MARK: - 命名のリテラル
/**********************************************************************/

struct StoreDataType {
    static let store = "店名"
    static let place = "場所"
    static let genre = "ジャンル"
}

struct CategoryPlaceHolder {
    static private let ex = "例) "
    static let store = ex + "サイゼリヤ"
    static let place = ex + "新宿"
    static let genre = ex + "イタリアン"
}

struct Mark {
    static let questions = "???"
}

struct AlertTitle {
    static let signUp_1 = "よく行くお店を登録しよう"
    static let signUp_2 = "お店を登録しますか？"
    static let delete = "お店一覧から削除しますか？"
    static let allTextEmpty = "全て空欄です"
    static let edit = "編集した内容を保存しますか？"
    static let email = "メールが開けません"
    static let error = "エラー"
}

struct AlertMessage {
    static let signUp = "お店がまだ登録されていません"
    static let allTextEmpty = "空欄に記入してください"
    static let email = "設定からメールアドレスを追加してください。"
    static let offline = "ネットワーク環境が不安定です\n設定をご確認ください"
}

struct AlertButtonTitle {
    static let signUp = "登録する"
    static let ok = "OK"
    static let cancel = "キャンセル"
    static let delete = "削除"
    static let save = "保存する"
}

struct ButtonTitle {
    static let signUp = "お店を登録"
    static let saveEdit = "編集を保存"
    static let cancel = "キャンセル"
}

struct SettingTitle {
    static let contact = "お問い合わせ"
    static let review = "レビューする"
    static let appVersion = "アプリバージョン"
}

struct EmailInfo {
    static let address = "harafuchi0324@gmail.com"
    static let subject = "【さいころdeごはん】お問い合わせ"
    static let messageBody_1 = "下記にお問い合わせ内容をお書きください。\n\n\n\n\nAppVersion: "
    static let messageBody_2 = "\nPlatformVersion: "
    static let messageBody_3 = "\nUserID: "
}

struct EmailStatus {
    static let noAddress = "有効なメールアドレスが存在しません"
    static let cancelled = "メールの作成がキャンセルされました"
    static let saved = "メールが下書きに保存されました"
    static let sent = "メールの送信に成功しました"
    static let failed = "メールの送信に失敗しました"
}

/**********************************************************************/
// MARK: - Layerのリテラル
/**********************************************************************/

struct ButtonCustomViewLayer {
    static let borderWidth: CGFloat = 1.0
    static let cornerRadius: CGFloat = 28.0
}

/**********************************************************************/
// MARK: - 色のリテラル
/**********************************************************************/

struct RandomChoiceAppColor {
    static let white = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let red = #colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1)
    static let yellow = #colorLiteral(red: 0.9921568627, green: 0.6393200201, blue: 0.218539124, alpha: 1)
}

/**********************************************************************/
// MARK: - IDのリテラル
/**********************************************************************/

struct CellIdentifier {
    static let randomChoiceButtonCell = "RandomChoiceButtonCell"
    static let listPageCell = "ListPageCell"
    static let signupCell = "SignupCell"
    static let actionButtonCell = "ActionButtonCell"
    static let settingCell = "SettingCell"
}

struct Nib {
    static let randomChoiceButtonTableViewCell = "RandomChoiceButtonTableViewCell"
    static let listPageTableViewCell = "ListPageTableViewCell"
    static let signupCategoryTableViewCell = "SignupCategoryTableViewCell"
    static let commonActionButtonTableViewCell = "CommonActionButtonTableViewCell"
    static let settingTableViewCell = "SettingTableViewCell"
}

struct SegueIdentifier {
    static let goToSignUpVC = "goToSignupVC"
    static let goToEditVC = "goToEditVC"
}

struct BundleIdentifier {
    static let appVersion = "CFBundleShortVersionString"
}

struct Url {
    // 「さいころdeごはん」AppStoreページのリンク
    static let appStoreReview = "https://apps.apple.com/jp/app/%E3%81%95%E3%81%84%E3%81%93%E3%82%8Dde%E3%81%94%E3%81%AF%E3%82%93/id1528912786?mt=8&action=write-review"
}
