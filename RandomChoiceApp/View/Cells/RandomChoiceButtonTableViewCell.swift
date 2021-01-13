//
//  RandomChoiceButtonTableViewCell.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/21.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class RandomChoiceButtonTableViewCell: UITableViewCell {
    
    var diceButtonTapHandler: ((_ sender: UIButton) -> Void)?
    
    @IBOutlet private weak var randomChoiceButton: UIButton!
    
    @IBAction func touchedRandomChoiceButton(_ sender: UIButton) {
        diceButtonTapHandler?(sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
    }
}

//MARK: -  Method
extension RandomChoiceButtonTableViewCell {
    private func setupDetailCell() {
        self.selectionStyle = .none
        randomChoiceButton.layer.shadowOpacity = 0.5
        randomChoiceButton.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}
