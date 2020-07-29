//
//  SignupCategoryTableViewCell.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/07/20.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

protocol SignupCategoryTableViewCellDelegate {
    func fetchCategoryNameText(textField: UITextField)
}

class SignupCategoryTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var delegete: SignupCategoryTableViewCellDelegate?

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var categoryTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        categoryTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegete?.fetchCategoryNameText(textField: textField)
        return true
    }
}
