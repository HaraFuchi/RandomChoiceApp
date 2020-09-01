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
        setupButtons()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Private
    private func setupButtons(){
        self.selectionStyle = .none
        cancelButton.setTitle(ButtonTittle.cancel, for: .normal)
        signUpButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.cornerRadius = 28.0
        cancelButton.layer.borderColor = #colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1)
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 28.0
    }
}
