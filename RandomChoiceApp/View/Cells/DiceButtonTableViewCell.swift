//
//  DiceButtonTableViewCell.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/21.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

final class DiceButtonTableViewCell: UITableViewCell {

    var buttonTapHandler: ((_ sender: UIButton) -> Void)?

    @IBOutlet private weak var diceButton: UIButton!

    @IBAction func didTapDiceButton(_ sender: UIButton) {
        buttonTapHandler?(sender)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
    }

    /**********************************************************************/
    // MARK: - Private Method
    /**********************************************************************/
    private func setupDetailCell() {
        selectionStyle = .none
        diceButton.layer.shadowOpacity = 0.5
        diceButton.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}
