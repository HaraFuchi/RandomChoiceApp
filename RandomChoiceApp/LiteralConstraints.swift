//
//  LiteralConstrains.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/30.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation

/**********************************************************************/
// MARK: - 命名のリテラル
/**********************************************************************/

struct StoreDataLiteral {
    static let store = "店名"
    static let place = "場所"
    static let genre = "ジャンル"
}

struct QuestionsLiteral {
    static let questions = "???"
}

struct AlertTitleLiteral {
    static let signUp_1 = "よく行くお店を登録しよう"
    static let signUp_2 = "お店を登録しますか？"
    static let delete = "お店一覧から削除しますか？"
    static let allTextEmpty = "全て空欄です"
    static let edit = "編集した内容を保存しますか？"
    static let email = "メールが開けません"
}

struct AlertMessageLiteral {
    static let signUp = "お店がまだ登録されていません"
    static let allTextEmpty = "空欄に記入してください"
    static let email = "設定からメールアドレスを追加してください。"
}

struct AlertButtonLiteral {
    static let signUp = "登録する"
    static let OK = "OK"
    static let cancel = "キャンセル"
    static let delete = "削除"
    static let save = "保存する"
}

struct ButtonTitleLiteral {
    static let signUp = "お店を登録"
    static let saveEdit = "編集を保存"
    static let cancel = "キャンセル"
}

struct EmailLiteral {
    static let emailAddress = "harafuchi0324@gmail.com"
    static let emailSubject = "【さいころdeごはん】お問い合わせ"
    static let messageBody_1 = "下記にお問い合わせ内容をお書きください。\n\n\n\n\nAppVersion: "
    static let messageBody_2 = "\nPlatformVersion: "
    static let messageBody_3 = "\nUserID: "
}

struct DebugEmailLiteral {
    static let noEmailAddress = "有効なメールアドレスが存在しません"
    static let cancelled = "メールの作成がキャンセルされました"
    static let saved = "メールが下書きに保存されました"
    static let sent = "メールの送信に成功しました"
    static let failed = "メールの送信に失敗しました"
}

/**********************************************************************/
// MARK: - IDのリテラル
/**********************************************************************/

struct CellIdentifierLiteral {
    static let randomChoiceButtonCell = "RandomChoiceButtonCell"
    static let listPageCell = "ListPageCell"
    static let signupCell = "SignupCell"
    static let actionButtonCell = "ActionButtonCell"
    static let settingCell = "SettingCell"
}

struct NibNameLiteral {
    static let randomChoiceButtonTableViewCell = "RandomChoiceButtonTableViewCell"
    static let listPageTableViewCell = "ListPageTableViewCell"
    static let signupCategoryTableViewCell = "SignupCategoryTableViewCell"
    static let commonActionButtonTableViewCell = "CommonActionButtonTableViewCell"
    static let settingTableViewCell = "SettingTableViewCell"
}

struct SegueIdentifierLiteral {
    static let goToSignUpVC = "goToSignupVC"
    static let goToEditVC = "goToEditVC"
}

struct BundleIdentifierLiteral {
    static let appVersion = "CFBundleShortVersionString"
}

struct UrlLiteral {
    //「さいころdeごはん」AppStoreページのリンク
    static let appStoreReviewUrl = "https://apps.apple.com/jp/app/%E3%81%95%E3%81%84%E3%81%93%E3%82%8Dde%E3%81%94%E3%81%AF%E3%82%93/id1528912786?mt=8&action=write-review"
}
