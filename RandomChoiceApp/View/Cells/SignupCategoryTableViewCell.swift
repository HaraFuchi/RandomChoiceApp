//
//  SignupCategoryTableViewCell.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/07/20.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

protocol SignupCategoryTableViewCellDelegate {
    func fetchCategoryNameText(textField: UITextField, cellType: CategoryListType)
}

class SignupCategoryTableViewCell: UITableViewCell {
    
    var delegate: SignupCategoryTableViewCellDelegate?
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
    
    var categoryTitle: String = "" {
        didSet {
            categoryLabel.text = categoryTitle
        }
    }
    
    var categoryText: String = "" {
        didSet {
            categoryTextField.text = categoryText
        }
    }
    
    var categoryPlaceHolder: String = "" {
        didSet {
            categoryTextField.placeholder = categoryPlaceHolder
        }
    }
    
    private func setupDetailCell() {
        self.selectionStyle = .none
        //TODO: 以下のプロパティが必要か検討
        categoryTextField.backgroundColor = .white
    }
}

extension SignupCategoryTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let cellType = cellType else { return }
        delegate?.fetchCategoryNameText(textField: textField, cellType: cellType)
    }
}
