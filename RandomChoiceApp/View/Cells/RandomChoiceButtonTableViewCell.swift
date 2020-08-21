//
//  RandomChoiceButtonTableViewCell.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/21.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

protocol RandomChoiceButtonTableViewCellDelegate {
    func didTapDiceButton()
}

class RandomChoiceButtonTableViewCell: UITableViewCell {
    
    var delegate: RandomChoiceButtonTableViewCellDelegate?
    
    //outlet
    @IBOutlet weak var randomChoiceButton: UIButton!
    
    //action
    @IBAction func touchedRandomChoiceButton(_ sender: UIButton) {
        delegate?.didTapDiceButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        randomChoiceButtonDetail()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Private
    private func randomChoiceButtonDetail() {
        randomChoiceButton.layer.borderColor = #colorLiteral(red: 0.9937663674, green: 0.4226302207, blue: 0.362043947, alpha: 1)
        randomChoiceButton.layer.borderWidth = 5.0
        randomChoiceButton.layer.cornerRadius = 100
        // 影の濃さを決める
        randomChoiceButton.layer.shadowOpacity = 0.5
        // 影のサイズを決める
        randomChoiceButton.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}
