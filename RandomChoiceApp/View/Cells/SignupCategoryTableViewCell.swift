//
//  SignupCategoryTableViewCell.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/07/20.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

protocol SignupCategoryTableViewCellDelegate {
    func fetchCategoryNameText(textField: UITextField, indexNumber: Int)
}

class SignupCategoryTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var delegate: SignupCategoryTableViewCellDelegate?
    var indexPathNumber:Int? //登録画面で繰り返すCellを分別する変数
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var categoryTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
        categoryTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.fetchCategoryNameText(textField: textField, indexNumber: indexPathNumber!)
    }
}

//MARK: - Method
extension SignupCategoryTableViewCell {
    private func setupDetailCell() {
        self.selectionStyle = .none
        categoryTextField.backgroundColor = .white
    }
}
