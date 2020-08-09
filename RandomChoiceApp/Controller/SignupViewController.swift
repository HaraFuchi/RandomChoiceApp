//
//  SignupViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var storeNameString: String?
    var placeNameString: String?
    var genreNameString: String?
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func touchedScreenRecognizer(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //CaseIterableを記述することでenum内の要素の個数が取得できる
    enum CategoryList: String, CaseIterable{
        case storeName = "店名"
        case placeName = "場所"
        case genreName = "ジャンル"
        
        var CategoryPlaceHolderList: String {
            switch self {
            case .storeName: return "例)サイゼリア"
            case .placeName: return "例)新宿"
            case .genreName: return "例)イタリアン"
            }
        }
    }
    
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
        return CategoryList.allCases.count + 1 //1はCommonActionButtonTableViewCellの分
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "SignupCell", for: indexPath) as! SignupCategoryTableViewCell
        let signupAndCancelButtonCell = tableView.dequeueReusableCell(withIdentifier: "ActionButtonCell", for: indexPath) as! CommonActionButtonTableViewCell
        
        categoryCell.delegete = self
        
        switch indexPath.row {
        case 0:
            categoryCell.categoryLabel.text = CategoryList.storeName.rawValue
            categoryCell.categoryTextField.placeholder = CategoryList.storeName.CategoryPlaceHolderList
            categoryCell.IndexPathNumber = indexPath.row
            return categoryCell
        case 1:
            categoryCell.categoryLabel.text = CategoryList.placeName.rawValue
            categoryCell.categoryTextField.placeholder = CategoryList.placeName.CategoryPlaceHolderList
            categoryCell.IndexPathNumber = indexPath.row
            return categoryCell
        case 2:
            categoryCell.categoryLabel.text = CategoryList.genreName.rawValue
            categoryCell.categoryTextField.placeholder = CategoryList.genreName.CategoryPlaceHolderList
            categoryCell.IndexPathNumber = indexPath.row
            return categoryCell
        case 3:
            signupAndCancelButtonCell.delegate = self
            return signupAndCancelButtonCell
        default:
            break
        }
        return UITableViewCell()
    }
}

extension SignupViewController: CommonActionButtonTableViewCellDelegate, SignupCategoryTableViewCellDelegate{
    func fetchCategoryNameText(textField: UITextField, indexNumber: Int) {
        switch indexNumber {
        case 0: storeNameString = textField.text
        case 1: placeNameString = textField.text
        case 2: genreNameString = textField.text
        default: break
        }
    }
    
    func signupStoreInfoButton() {
        let ref = Database.database().reference()
        // KeyValue型の配列を用意しておく
        let registerInfoArray = ["店名": storeNameString, "場所": placeNameString, "ジャンル": genreNameString]
        ref.child(Auth.auth().currentUser!.uid).childByAutoId().setValue(registerInfoArray)
        print("ボタン押されたよ")
        print(storeNameString)
        print(placeNameString)
        print(genreNameString)
    }
    
    func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
}
