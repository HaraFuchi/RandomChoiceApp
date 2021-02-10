//
//  SettingTableViewCell.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/11/23.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet private weak var settingTitleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var isSubTitleLabelHidden: Bool = false {
        didSet {
            subTitleLabel?.isHidden = isSubTitleLabelHidden
        }
    }

    var titleText: String? {
        didSet {
            settingTitleLabel?.text = titleText
        }
    }

    var subTitleText: String? {
        didSet {
            subTitleLabel?.text = subTitleText
        }
    }
}
