//
//  SignupCategoryTableViewCell.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/07/20.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

protocol SignupCategoryViewDelegate: AnyObject {
    func textField(_ textField: UITextField, cellType categoryListType: CategoryListType)
}

final class SignupCategoryTableViewCell: UITableViewCell {

    weak var delegate: SignupCategoryViewDelegate?
    var cellType: CategoryListType?

    @IBOutlet private var categoryLabel: UILabel!
    @IBOutlet private var categoryTextField: UITextField! {
        didSet {
            categoryTextField.delegate = self
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
    }

    private var categoryTitle: String? {
        didSet {
            categoryLabel.text = categoryTitle
        }
    }

    private var categoryText: String? {
        didSet {
            categoryTextField.text = categoryText
        }
    }

    private var categoryPlaceHolder: String? {
        didSet {
            categoryTextField.placeholder = categoryPlaceHolder
        }
    }

    /// カテゴリー入力欄に値を入れる
    /// - Parameters:
    ///   - title: 入力欄のタイトル
    ///   - placeHolder: 入力欄のプレースホルダー
    ///   - cellType: セルの種類
    /// - Returns: 戻り値の説明
    func setText(title: String, placeHolder: String, cellType: CategoryListType) {
        categoryTitle = title
        categoryPlaceHolder = placeHolder
        self.cellType = cellType
    }

    /// カテゴリー入力欄に値を入れる
    /// - Parameters:
    ///   - title: 入力欄のタイトル
    ///   - date: 入力したデータ
    ///   - cellType: セルの種類
    /// - Returns: 戻り値の説明
    func setText(title: String, data: String?, cellType: CategoryListType) {
        categoryTitle = title
        categoryText = data
        self.cellType = cellType
    }

    /**********************************************************************/
    // MARK: - Private Method
    /**********************************************************************/
    private func setupDetailCell() {
        selectionStyle = .none
        categoryTextField.backgroundColor = .white
    }
}

/**********************************************************************/
// MARK: - Protocol
/**********************************************************************/
extension SignupCategoryTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let cellType = cellType else { return }
        delegate?.textField(textField, cellType: cellType)
    }
}
