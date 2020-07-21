//
//  RandomChoiceButtonTableViewCell.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/21.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class RandomChoiceButtonTableViewCell: UITableViewCell {
    
    //outlet
    @IBOutlet weak var randomChoiceButton: UIButton!
    
    //action
    @IBAction func touchedRandomChoiceButton(_ sender: UIButton) {
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        randomChoiceButtonDetail()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    //MARK: - Private
    private func randomChoiceButtonDetail() {
        randomChoiceButton.setTitle("お店を決める", for: .normal)
         randomChoiceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        randomChoiceButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        randomChoiceButton.backgroundColor = #colorLiteral(red: 0.9937663674, green: 0.4226302207, blue: 0.362043947, alpha: 1)
        randomChoiceButton.layer.borderColor = #colorLiteral(red: 0.9937663674, green: 0.4226302207, blue: 0.362043947, alpha: 1)
        randomChoiceButton.layer.borderWidth = 5.0
        randomChoiceButton.layer.cornerRadius = 90
        // 影の濃さを決める
        randomChoiceButton.layer.shadowOpacity = 0.5
        // 影のサイズを決める
        randomChoiceButton.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}
