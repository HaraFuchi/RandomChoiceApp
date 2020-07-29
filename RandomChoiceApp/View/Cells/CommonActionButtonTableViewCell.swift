//
//  CommonActionButtonTableViewCell.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/07/21.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

protocol CommonActionButtonTableViewCellDelegate {
    func cancelButton()
}

class CommonActionButtonTableViewCell: UITableViewCell {
    
    var delegate: CommonActionButtonTableViewCellDelegate?
    let signupVC = SignupViewController()
    
    //outlet
    @IBOutlet weak var singupButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    //action
    @IBAction func touchedSignupButton(_ sender: UIButton) {
        
        let signupDB = Database.database().reference()
        let store = signupVC.store
        let place = signupVC.place
        let genre = signupVC.genre
        let signupInfo = ["店名": store, "場所": place, "ジャンル": genre]
        
        signupDB.childByAutoId().setValue(signupInfo) { (error, result) in
            if error != nil {
                print(error)
            } else {
                print("保存完了！")
            }
        }
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
        singupButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        singupButton.layer.borderWidth = 1.0
        singupButton.layer.cornerRadius = 28.0
        cancelButton.layer.borderColor = #colorLiteral(red: 0.9972122312, green: 0.4152126908, blue: 0.3679206967, alpha: 1)
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 28.0
    }
}
