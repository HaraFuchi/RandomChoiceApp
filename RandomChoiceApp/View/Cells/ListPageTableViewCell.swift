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
    var indexPathNumber: Int? // Cellに分別する変数
    
    @IBOutlet private weak var BGBaseView: UIView!
    // TODO: 下3つの名称を統一させる
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    // TODO: アクション接続はdidTapxxxにリネームする
    @IBAction func touchedEditButton(_ sender: UIButton) {
        // TODO: 命名がindexPathだと、indexPath型だと勘違いする可能性があるためリネーム(実際はInt型)
        if let indexPath = indexPathNumber {
            delegate?.didTapEditButton(indexPath: indexPath)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
    }
}

//MARK: - Method
extension ListPageTableViewCell {
    private func setupDetailCell(){
        self.selectionStyle = .none
        BGBaseView.layer.cornerRadius = 8
    }
}
