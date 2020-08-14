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
    
    var delegete: SignupCategoryTableViewCellDelegate?
    var IndexPathNumber:Int?//登録画面で繰り返しすCellを分別するのコード
    
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegete?.fetchCategoryNameText(textField: textField, indexNumber: IndexPathNumber!)
    }
}
