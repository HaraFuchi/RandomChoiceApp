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

    var categoryTitle: String? {
        didSet {
            categoryLabel.text = categoryTitle
        }
    }

    var categoryText: String? {
        didSet {
            categoryTextField.text = categoryText
        }
    }

    var categoryPlaceHolder: String? {
        didSet {
            categoryTextField.placeholder = categoryPlaceHolder
        }
    }

    // MARK: - Private Method
    private func setupDetailCell() {
        self.selectionStyle = .none
        categoryTextField.backgroundColor = .white
    }
}

// MARK: - Protocol
extension SignupCategoryTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let cellType = cellType else { return }
        delegate?.textField(textField, cellType: cellType)
    }
}
