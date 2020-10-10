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
    
    public func setupButtons(_ VC: UIViewController) {
        commonSetUpButton()
        if VC is SignupViewController {
            signUpButton.setTitle(ButtonTitleLiteral.signUp, for: .normal)
            signUpButton.backgroundColor = #colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1)
            cancelButton.setTitle(ButtonTitleLiteral.cancel, for: .normal)
            cancelButton.setTitleColor(#colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1), for: .normal)
            cancelButton.layer.borderColor = #colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1)
        } else if VC is EditViewController {
            signUpButton.setTitle(ButtonTitleLiteral.saveEdit, for: .normal)
            signUpButton.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.6393200201, blue: 0.218539124, alpha: 1)
            cancelButton.setTitle(ButtonTitleLiteral.cancel, for: .normal)
            cancelButton.setTitleColor(#colorLiteral(red: 0.9921568627, green: 0.6393200201, blue: 0.218539124, alpha: 1), for: .normal)
            cancelButton.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.6393200201, blue: 0.218539124, alpha: 1)
        }
    }
    
    private func commonSetUpButton() {
        signUpButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        signUpButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.cornerRadius = 28.0
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 28.0
    }
    
    //FIXME: 登録画面と編集画面で配色を条件分岐する
    func setupButtons_signUp() {
        
    }
    
    func setupButtons_edit() {
        
    }
}
