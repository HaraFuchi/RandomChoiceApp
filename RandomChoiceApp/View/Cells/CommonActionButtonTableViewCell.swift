//
//  CommonActionButtonTableViewCell.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/07/21.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

protocol CommonActionButtonTableViewCellDelegate: AnyObject {
    func cancelButton()
    //TODO 使用されている部分が登録のみではないためリネームする
    func signupStoreInfoButton()
}

class CommonActionButtonTableViewCell: UITableViewCell {
    
    weak var delegate: CommonActionButtonTableViewCellDelegate?
    
    //TODO 使用されている部分が登録のみではないためリネームする
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    //TODO 使用されている部分が登録のみではないためリネームする
    //TODO actionはdidTapから始める
    @IBAction func touchedSignupButton(_ sender: UIButton) {
        delegate?.signupStoreInfoButton()
    }
    
    //TODO actionはdidTapから始める
    @IBAction func touchedCancelButton(_ sender: UIButton) {
        delegate?.cancelButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
    }
}

// MARK: - Method
extension CommonActionButtonTableViewCell {
    private func setupDetailCell() {
        self.selectionStyle = .none
    }
    
    func setupButton(_ VC: UIViewController) {
        if VC is SignupViewController {
            signupButtonDetailInSignupScreen()
            cancelButtonDetailInSignupScreen()
        } else if VC is EditViewController {
            signupButtonDetailInEditScreen()
            cancelButtonDetailInEditScreen()
        }
    }
    
    private func signupButtonDetailInSignupScreen() {
        signUpButton.setTitle(ButtonTitle.signUp, for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1)
        signUpButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        signUpButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.cornerRadius = 28.0
    }
    
    private func cancelButtonDetailInSignupScreen() {
        cancelButton.setTitle(ButtonTitle.cancel, for: .normal)
        cancelButton.layer.borderColor = #colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1)
        cancelButton.setTitleColor(#colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1), for: .normal)
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 28.0
    }
    
    private func signupButtonDetailInEditScreen() {
        signUpButton.setTitle(ButtonTitle.saveEdit, for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.6393200201, blue: 0.218539124, alpha: 1)
        signUpButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        signUpButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.cornerRadius = 28.0
    }
    
    private func cancelButtonDetailInEditScreen() {
        cancelButton.setTitle(ButtonTitle.cancel, for: .normal)
        cancelButton.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.6393200201, blue: 0.218539124, alpha: 1)
        cancelButton.setTitleColor(#colorLiteral(red: 0.9921568627, green: 0.6393200201, blue: 0.218539124, alpha: 1), for: .normal)
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 28.0
    }
}
