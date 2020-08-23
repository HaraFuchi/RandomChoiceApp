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
        // 影の濃さを決める
        randomChoiceButton.layer.shadowOpacity = 0.5
        // 影のサイズを決める
        randomChoiceButton.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}
