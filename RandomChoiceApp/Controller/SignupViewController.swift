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
        tableView.register(sinupCategoryNib, forCellReuseIdentifier: "SignupCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignupCell", for: indexPath) as! SignupCategoryTableViewCell
        switch indexPath.row {//リファクタリング候補
        case 0:
            cell.categoryLabel.text = CategoryNameArray[indexPath.row]
            cell.categoryTextField.placeholder = CategoryPlaceHolderArray[indexPath.row]
        case 1:
            cell.categoryLabel.text = CategoryNameArray[indexPath.row]
            cell.categoryTextField.placeholder = CategoryPlaceHolderArray[indexPath.row]
        case 2:
            cell.categoryLabel.text = CategoryNameArray[indexPath.row]
            cell.categoryTextField.placeholder = CategoryPlaceHolderArray[indexPath.row]
        default:
            break
        }
        return cell
    }
}
