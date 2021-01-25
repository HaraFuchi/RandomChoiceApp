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
}

// TODO: extensionを外す
// MARK: - Method
extension CommonActionButtonTableViewCell {
    private func setupDetailCell() {
        self.selectionStyle = .none
    }
    //FIXME 同じようなプロパティを繰り返し使用しているため修正する
    func setupButton(_ VC: UIViewController) {
        setUpCommonButton()
        if VC is SignupViewController {
            signUpButton.setTitle(ButtonTitle.signUp, for: .normal)
            signUpButton.backgroundColor = #colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1)
            cancelButton.setTitle(ButtonTitle.cancel, for: .normal)
            cancelButton.setTitleColor(#colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1), for: .normal)
            cancelButton.layer.borderColor = #colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1)
        } else if VC is EditViewController {
            signUpButton.setTitle(ButtonTitle.saveEdit, for: .normal)
            signUpButton.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.6393200201, blue: 0.218539124, alpha: 1)
            cancelButton.setTitle(ButtonTitle.cancel, for: .normal)
            cancelButton.setTitleColor(#colorLiteral(red: 0.9921568627, green: 0.6393200201, blue: 0.218539124, alpha: 1), for: .normal)
            cancelButton.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.6393200201, blue: 0.218539124, alpha: 1)
        }
    }
    
    private func setUpCommonButton() {
        signUpButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        signUpButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.cornerRadius = 28.0
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 28.0
    }
}
