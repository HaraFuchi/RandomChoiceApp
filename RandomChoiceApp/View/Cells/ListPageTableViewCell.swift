//
//  ListPageTableViewCell.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/20.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

protocol ListPageTableViewCellDelegate: AnyObject {
    func didTapEditButton(indexPath: Int)
}

class ListPageTableViewCell: UITableViewCell {
    
    weak var delegate: ListPageTableViewCellDelegate?
    
    var indexPathNumber: Int? //Cellに分別する変数
    
    @IBOutlet private weak var BGBaseView: UIView!
    @IBOutlet private weak var storeNameLabel: UILabel!
    @IBOutlet private weak var placeLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var editButton: UIButton!
    
    @IBAction func touchedEditButton(_ sender: UIButton) {
        if let indexPath = indexPathNumber {
            delegate?.didTapEditButton(indexPath: indexPath)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDetailCell()
    }
    
    var storeDataText: String = "" {
        didSet {
            storeNameLabel.text = storeDataText
        }
    }
    
    var placeDataText: String = "" {
        didSet {
            placeLabel.text = placeDataText
        }
    }
    
    var genreDataText: String = "" {
        didSet {
            genreLabel.text = genreDataText
        }
    }
    
    var isHiddenEditButton: Bool = false {
        didSet {
            editButton.isHidden = isHiddenEditButton
        }
    }
}

//MARK: - Method
extension ListPageTableViewCell {
    private func setupDetailCell(){
        self.selectionStyle = .none
        BGBaseView.layer.cornerRadius = 8
    }
}
