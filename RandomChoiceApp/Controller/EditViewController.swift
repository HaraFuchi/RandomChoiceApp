//
//  EditViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/08/28.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITableViewDataSource, UINavigationBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    //TFに入れる値を所持
    var editStoreName: String?
    var editPlaceName: String?
    var editGenreName: String?
    
    //UINavigationBarをステータスバーまで広げる
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
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
        setUpTableView()
        navigationBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryList.allCases.count + 1 //1は登録ボタン(CommonActionButtonTableViewCell)の分
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "SignupCell", for: indexPath) as! SignupCategoryTableViewCell
        let signupAndCancelButtonCell = tableView.dequeueReusableCell(withIdentifier: "ActionButtonCell", for: indexPath) as! CommonActionButtonTableViewCell
        
        textConvertNil()
        
        switch indexPath.row {
        case 0:
            categoryCell.categoryLabel.text = CategoryList.storeName.rawValue
            categoryCell.categoryTextField.text = editStoreName
            categoryCell.indexPathNumber = indexPath.row
            return categoryCell
        case 1:
            categoryCell.categoryLabel.text = CategoryList.placeName.rawValue
            categoryCell.categoryTextField.text = editPlaceName
            categoryCell.indexPathNumber = indexPath.row
            return categoryCell
        case 2:
            categoryCell.categoryLabel.text = CategoryList.genreName.rawValue
            categoryCell.categoryTextField.text = editGenreName
            categoryCell.indexPathNumber = indexPath.row
            return categoryCell
        case 3:
            signupAndCancelButtonCell.delegate = self
            signupAndCancelButtonCell.signUpButton.setTitle(ButtonTittle.saveEdit, for: .normal)
            return signupAndCancelButtonCell
        default: break
        }
        return UITableViewCell()
    }
}

//MARK: - Protocol
extension EditViewController: CommonActionButtonTableViewCellDelegate {
    func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func signupStoreInfoButton() {
    }
}

//MARK: - Method
extension EditViewController {
    private func setUpTableView() {
        tableView.dataSource = self
        let singUpCategoryNib = UINib(nibName: "SignupCategoryTableViewCell", bundle: nil)
        let signupAndCancelButtonCell = UINib(nibName: "CommonActionButtonTableViewCell", bundle: nil)
        tableView.register(singUpCategoryNib, forCellReuseIdentifier: "SignupCell")
        tableView.register(signupAndCancelButtonCell, forCellReuseIdentifier: "ActionButtonCell")
    }
    
    //TFに???を反映させる必要はないため、nilを返す
    private func textConvertNil() {
        if editStoreName == "???" {
            editStoreName = nil
        }
        if editPlaceName == "???" {
            editPlaceName = nil
        }
        if editGenreName == "???" {
            editGenreName = nil
        }
    }
}
