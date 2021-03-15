//
//  CommonActionButtonTableViewCell.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/07/21.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

final class CommonActionButtonTableViewCell: UITableViewCell {

    var signupButtonTapHandler: ((_ sender: UIButton) -> Void)?
    var cancelButtonTapHandler: ((_ sender: UIButton) -> Void)?

    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!

    @IBAction func didTapSignupButton(_ sender: UIButton) {
        signupButtonTapHandler?(sender)
    }

    @IBAction func didTapCancelButton(_ sender: UIButton) {
        cancelButtonTapHandler?(sender)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
    }

    private func setupDetailCell() {
        self.selectionStyle = .none
    }

    func setupButton(_ vc: UIViewController) { // swiftlint:disable:this identifier_name
        if vc is SignupViewController {
            signupButtonDetailInSignupScreen()
            cancelButtonDetailInSignupScreen()
        } else if vc is EditViewController {
            signupButtonDetailInEditScreen()
            cancelButtonDetailInEditScreen()
        }
    }

    // MARK: - Private Method
    private func signupButtonDetailInSignupScreen() {
        signUpButton.setTitle(ButtonTitle.signUp, for: .normal)
        signUpButton.backgroundColor = RandomChoiceAppColor.red
        signUpButton.setTitleColor(RandomChoiceAppColor.white, for: .normal)
        signUpButton.layer.borderColor = RandomChoiceAppColor.white.cgColor
        signUpButton.layer.borderWidth = ButtonCustomViewLayer.borderWidth
        signUpButton.layer.cornerRadius = ButtonCustomViewLayer.cornerRadius
    }

    private func cancelButtonDetailInSignupScreen() {
        cancelButton.setTitle(ButtonTitle.cancel, for: .normal)
        cancelButton.layer.borderColor = RandomChoiceAppColor.red.cgColor
        cancelButton.setTitleColor(RandomChoiceAppColor.red, for: .normal)
        cancelButton.layer.borderWidth = ButtonCustomViewLayer.borderWidth
        cancelButton.layer.cornerRadius = ButtonCustomViewLayer.cornerRadius
    }

    private func signupButtonDetailInEditScreen() {
        signUpButton.setTitle(ButtonTitle.saveEdit, for: .normal)
        signUpButton.backgroundColor = RandomChoiceAppColor.yellow
        signUpButton.setTitleColor(RandomChoiceAppColor.white, for: .normal)
        signUpButton.layer.borderColor = RandomChoiceAppColor.white.cgColor
        signUpButton.layer.borderWidth = ButtonCustomViewLayer.borderWidth
        signUpButton.layer.cornerRadius = ButtonCustomViewLayer.cornerRadius
    }

    private func cancelButtonDetailInEditScreen() {
        cancelButton.setTitle(ButtonTitle.cancel, for: .normal)
        cancelButton.layer.borderColor = RandomChoiceAppColor.yellow.cgColor
        cancelButton.setTitleColor(RandomChoiceAppColor.yellow, for: .normal)
        cancelButton.layer.borderWidth = ButtonCustomViewLayer.borderWidth
        cancelButton.layer.cornerRadius = ButtonCustomViewLayer.cornerRadius
    }
}
