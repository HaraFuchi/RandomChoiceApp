//
//  SignupViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var CategoryNameArray:[String] = ["店名","場所","ジャンル"]//リファクタリング候補
    var CategoryPlaceHolderArray :[String] = ["例)サイゼリア","例)新宿","例)中華"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let sinupCategoryNib = UINib(nibName: "SignupCategoryTableViewCell", bundle: nil)
        let signupAndCancelButtonCell = UINib(nibName: "CommonActionButtonTableViewCell", bundle: nil)
        tableView.register(sinupCategoryNib, forCellReuseIdentifier: "SignupCell")
        tableView.register(signupAndCancelButtonCell, forCellReuseIdentifier: "ActionButtonCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryNameArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "SignupCell", for: indexPath) as! SignupCategoryTableViewCell
        let signupAndCancelButtonCell = tableView.dequeueReusableCell(withIdentifier: "ActionButtonCell", for: indexPath) as! CommonActionButtonTableViewCell
    
        switch indexPath.row {//リファクタリング候補
        case 0:
            categoryCell.categoryLabel.text = CategoryNameArray[indexPath.row]
            categoryCell.categoryTextField.placeholder = CategoryPlaceHolderArray[indexPath.row]
            return categoryCell
        case 1:
            categoryCell.categoryLabel.text = CategoryNameArray[indexPath.row]
            categoryCell.categoryTextField.placeholder = CategoryPlaceHolderArray[indexPath.row]
            return categoryCell
        case 2:
            categoryCell.categoryLabel.text = CategoryNameArray[indexPath.row]
            categoryCell.categoryTextField.placeholder = CategoryPlaceHolderArray[indexPath.row]
            return categoryCell
        case 3:
            return signupAndCancelButtonCell
        default:
            break
        }
        return UITableViewCell()
    }
}
