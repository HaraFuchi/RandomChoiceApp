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
    
    @IBOutlet weak var randomChoiceButton: UIButton!
    
    @IBAction func touchedRandomChoiceButton(_ sender: UIButton) {
        delegate?.didTapDiceButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        randomChoiceButtonDetail()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: -  Method
extension RandomChoiceButtonTableViewCell {
    private func randomChoiceButtonDetail() {
        self.selectionStyle = .none
        randomChoiceButton.layer.shadowOpacity = 0.5
        randomChoiceButton.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}
