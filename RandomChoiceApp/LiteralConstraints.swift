//
//  LiteralConstrains.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/30.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation

struct StoreDataLiteral {
    static let store = "店名"
    static let place = "場所"
    static let genre = "ジャンル"
}

struct LiteralQuestions {
    static let questions = "???"
}

struct AlertTitleLiteral {
    static let signUp_1 = "よく行くお店を登録しよう"
    static let signUp_2 = "お店を登録しますか？"
    static let delete = "お店一覧から削除しますか？"
    static let allTextEmpty = "全て空欄です"
}

struct AlertMessageLiteral {
    static let signUp = "お店がまだ登録されていません"
    static let allTextEmpty = "空欄に記入してください"
}

struct AlertButtonLiteral {
    static let signUp = "登録する"
    static let OK = "OK"
    static let cancel = "キャンセル"
    static let delete = "削除"
}

struct ButtonTittle {
    static let signUp = "お店を登録"
    static let saveEdit = "編集を保存"
    static let cancel = "キャンセル"
}

struct CellIdentifierLiteral {
    static let randomChoiceButtonCell = "RandomChoiceButtonCell"
    static let listPageViewCell = "ListPageViewCell"
    static let listPageCell = "ListPageCell"
    //FIXME:上2つは統合できそう
    static let signupCell = "SignupCell"
    static let actionButtonCell = "ActionButtonCell"
}

struct NibNameLiteral {
    static let randomChoiceButtonTableViewCell = "RandomChoiceButtonTableViewCell"
    static let listPageTableViewCell = "ListPageTableViewCell"
    static let signupCategoryTableViewCell = "SignupCategoryTableViewCell"
    static let commonActionButtonTableViewCell = "CommonActionButtonTableViewCell"
}

struct SegueIdentifierLiteral {
    static let goToSignUpVC = "goToSignupVC"
    static let goToEditVC = "goToEditVC"
}
