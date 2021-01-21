//
//  CommonActionButtonTableViewCell.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/07/21.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

protocol actionButtonProtocal: AnyObject {
    func didTapCancel()
}

class CommonActionButtonTableViewCell: UITableViewCell {
    
    weak var delegate: actionButtonProtocal?
    var signupButtonTapHandler: ((_ sender: UIButton) -> Void)?
    
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    @IBAction func didTapSignupButton(_ sender: UIButton) {
        signupButtonTapHandler?(sender)
    }
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        delegate?.didTapCancel()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
    }
    
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
        signUpButton.backgroundColor = Color.red
        signUpButton.setTitleColor(Color.white, for: .normal)
        signUpButton.layer.borderColor = Color.white.cgColor
        signUpButton.layer.borderWidth = Layer.borderWidth
        signUpButton.layer.cornerRadius = Layer.cornerRadius
    }
    
    private func cancelButtonDetailInSignupScreen() {
        cancelButton.setTitle(ButtonTitle.cancel, for: .normal)
        cancelButton.layer.borderColor = Color.red.cgColor
        cancelButton.setTitleColor(Color.red, for: .normal)
        cancelButton.layer.borderWidth = Layer.borderWidth
        cancelButton.layer.cornerRadius = Layer.cornerRadius
    }
    
    private func signupButtonDetailInEditScreen() {
        signUpButton.setTitle(ButtonTitle.saveEdit, for: .normal)
        signUpButton.backgroundColor = Color.yellow
        signUpButton.setTitleColor(Color.white, for: .normal)
        signUpButton.layer.borderColor = Color.white.cgColor
        signUpButton.layer.borderWidth = Layer.borderWidth
        signUpButton.layer.cornerRadius = Layer.cornerRadius
    }
    
    private func cancelButtonDetailInEditScreen() {
        cancelButton.setTitle(ButtonTitle.cancel, for: .normal)
        cancelButton.layer.borderColor = Color.yellow.cgColor
        cancelButton.setTitleColor(Color.yellow, for: .normal)
        cancelButton.layer.borderWidth = Layer.borderWidth
        cancelButton.layer.cornerRadius = Layer.cornerRadius
    }
}
