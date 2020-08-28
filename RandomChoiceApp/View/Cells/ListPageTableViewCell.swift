//
//  ListPageTableViewCell.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/20.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class ListPageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroungBaseView: UIView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //MARK: - Private
    private func setupDetailCell(){
        self.selectionStyle = .none
        backgroungBaseView.layer.cornerRadius = 8
    }
}
