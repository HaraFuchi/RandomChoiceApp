//
//  SettingTableViewCell.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/11/23.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    var indexPathNumber:Int?//登録画面で繰り返すCellを分別する変数
    
    @IBOutlet weak var settingTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
