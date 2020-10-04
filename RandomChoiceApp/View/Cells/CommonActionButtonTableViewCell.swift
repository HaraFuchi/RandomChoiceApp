//
//  CommonActionButtonTableViewCell.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/07/21.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

protocol CommonActionButtonTableViewCellDelegate {
    func cancelButton()
    func signupStoreInfoButton()
}

class CommonActionButtonTableViewCell: UITableViewCell {
    
    var delegate: CommonActionButtonTableViewCellDelegate?
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func touchedSignupButton(_ sender: UIButton) {
        delegate?.signupStoreInfoButton()
    }
    @IBAction func touchedCancelButton(_ sender: UIButton) {
        delegate?.cancelButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Method
extension CommonActionButtonTableViewCell {
    private func setupDetailCell() {
        self.selectionStyle = .none
    }
    
    //FIXME: 登録画面と編集画面で配色を条件分岐する
    func setupButtons_signUp() {
        signUpButton.setTitle(ButtonTitleLiteral.signUp, for: .normal)
        signUpButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1)
        signUpButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.cornerRadius = 28.0
        cancelButton.setTitle(ButtonTitleLiteral.cancel, for: .normal)
        cancelButton.setTitleColor(#colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1), for: .normal)
        cancelButton.layer.borderColor = #colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1)
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 28.0
    }
    
    func setupButtons_edit() {
        signUpButton.setTitle(ButtonTitleLiteral.saveEdit, for: .normal)
        signUpButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.9821648002, green: 0.817013079, blue: 0.2579555598, alpha: 1)
        signUpButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.cornerRadius = 28.0
        cancelButton.setTitle(ButtonTitleLiteral.cancel, for: .normal)
        cancelButton.setTitleColor(#colorLiteral(red: 0.9821648002, green: 0.817013079, blue: 0.2579555598, alpha: 1), for: .normal)
        cancelButton.layer.borderColor = #colorLiteral(red: 0.9821648002, green: 0.817013079, blue: 0.2579555598, alpha: 1)
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 28.0
    }
}
