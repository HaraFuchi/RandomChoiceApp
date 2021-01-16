//
//  RandomChoiceButtonTableViewCell.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/21.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

protocol diceButtonViewProtocal: AnyObject {
    func didTapDiceButton() -> Void
}

class RandomChoiceButtonTableViewCell: UITableViewCell {
    
    weak var delegate: diceButtonViewProtocal?
    
    @IBOutlet private weak var diceButton: UIButton!
    
    @IBAction func didTapDiceButton(_ sender: UIButton) {
        delegate?.didTapDiceButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
    }
    
    private func setupDetailCell() {
        self.selectionStyle = .none
        diceButton.layer.shadowOpacity = 0.5
        diceButton.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}
