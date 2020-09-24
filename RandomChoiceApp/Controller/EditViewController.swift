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
    
    let crudModel = StoreDataCrudModel()
    var emptyNameText: String { return "???" }
    
    //TFに入れる値を所持
    var editStoreNameString: String?
    var editPlaceNameString: String?
    var editGenreNameString: String?
    var childID: String?
    
    //UINavigationBarをステータスバーまで広げる
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    enum CategoryList: String, CaseIterable{
        case storeName = "店名"
        case placeName = "場所"
        case genreName = "ジャンル"
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
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.signupCell, for: indexPath) as! SignupCategoryTableViewCell
        let signupAndCancelButtonCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.actionButtonCell, for: indexPath) as! CommonActionButtonTableViewCell
        
        convertValueNil()
        categoryCell.delegate = self
        
        switch indexPath.row {
        case 0:
            categoryCell.categoryLabel.text = CategoryList.storeName.rawValue
            categoryCell.categoryTextField.text = editStoreNameString
            categoryCell.indexPathNumber = indexPath.row
            return categoryCell
        case 1:
            categoryCell.categoryLabel.text = CategoryList.placeName.rawValue
            categoryCell.categoryTextField.text = editPlaceNameString
            categoryCell.indexPathNumber = indexPath.row
            return categoryCell
        case 2:
            categoryCell.categoryLabel.text = CategoryList.genreName.rawValue
            categoryCell.categoryTextField.text = editGenreNameString
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
extension EditViewController: SignupCategoryTableViewCellDelegate, CommonActionButtonTableViewCellDelegate {
    func fetchCategoryNameText(textField: UITextField, indexNumber: Int) {
        enum CategoryNameText: Int {
            case store
            case place
            case genre
        }
        
        let categoryNameText = CategoryNameText(rawValue: indexNumber)
        switch categoryNameText {
        case .store: editStoreNameString = textField.text
        case .place: editPlaceNameString = textField.text
        case .genre: editGenreNameString = textField.text
        case .none: break
        }
    }
    
    func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func signupStoreInfoButton() {
        showEditAlert()
    }
}

//MARK: - Method
extension EditViewController {
    
    private func setUpTableView() {
        tableView.dataSource = self
        let singUpCategoryNib = UINib(nibName: NibNameLiteral.signupCategoryTableViewCell, bundle: nil)
        let signupAndCancelButtonCell = UINib(nibName: NibNameLiteral.commonActionButtonTableViewCell, bundle: nil)
        tableView.register(singUpCategoryNib, forCellReuseIdentifier: CellIdentifierLiteral.signupCell)
        tableView.register(signupAndCancelButtonCell, forCellReuseIdentifier: CellIdentifierLiteral.actionButtonCell)
    }
    
    //TFに???を反映させる必要はないため、nilを返す
    private func convertValueNil() {
        if editStoreNameString == LiteralQuestions.questions {
            editStoreNameString = nil
        }
        if editPlaceNameString == LiteralQuestions.questions {
            editPlaceNameString = nil
        }
        if editGenreNameString == LiteralQuestions.questions {
            editGenreNameString = nil
        }
    }
    
    private func showEditAlert() {
        let alert = UIAlertController(title: AlertTitleLiteral.edit, message: nil, preferredStyle: .alert)
        let editAction = UIAlertAction(title: AlertButtonLiteral.save, style: .default) { _ in
            //Firebaseの更新機能追加
            self.textConvertNil()
            self.editAction()
        }
        let cancelAction = UIAlertAction(title: AlertButtonLiteral.cancel, style: .cancel, handler: nil)
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    //TFが""の場合Cellのレイアウトが崩れるため、nilを返して「???」を返す
    private func textConvertNil() {
        if editStoreNameString?.isEmpty == true {
            editStoreNameString = nil
        }
        if editPlaceNameString?.isEmpty == true {
            editPlaceNameString = nil
        }
        if editGenreNameString?.isEmpty == true {
            editGenreNameString = nil
        }
    }
    
    private func editAction() {
        if editStoreNameString == nil, editPlaceNameString == nil, editGenreNameString == nil {
            showAlertAllNilTextField()
        } else {
            crudModel.editStoreData(store: editStoreNameString ?? emptyNameText, place: editPlaceNameString ?? emptyNameText, genre: editGenreNameString ?? emptyNameText, childID: childID)
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func showAlertAllNilTextField() {
        let alert = UIAlertController(title: AlertTitleLiteral.allTextEmpty, message: AlertMessageLiteral
            .allTextEmpty, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: AlertButtonLiteral.OK, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
