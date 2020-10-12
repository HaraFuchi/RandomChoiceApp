//
//  ListPageTableViewCell.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/20.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

protocol ListPageTableViewCellDelegate {
    func didTapEditButton(indexPath: Int)
}

class ListPageTableViewCell: UITableViewCell {
    
    var delegate: ListPageTableViewCellDelegate?
    
    var indexPathNumber: Int?//Cellに分別する変数
    
    @IBOutlet weak var BGBaseView: UIView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func touchedEditButton(_ sender: UIButton) {
        if let indexPath = indexPathNumber {
            delegate?.didTapEditButton(indexPath: indexPath)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: - Method
extension ListPageTableViewCell {
    private func setupDetailCell(){
        self.selectionStyle = .none
        BGBaseView.layer.cornerRadius = 8
    }
}
