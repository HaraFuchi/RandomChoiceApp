//
//  SelectConditionsTableViewCell.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/21.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class SelectConditionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeConditionLabel: UILabel!
    @IBOutlet weak var genreConditionLabel: UILabel!
    @IBOutlet weak var placeSelectPicker: UIPickerView!
    @IBOutlet weak var genreSelectPicker: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
