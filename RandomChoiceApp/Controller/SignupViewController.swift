//
//  SignupViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITableViewDataSource, UINavigationBarDelegate, AlertDisplayable{
    
    //登録する内容の値を保持
    private var storeNameString: String?
    private var placeNameString: String?
    private var genreNameString: String?
        
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private weak var navigationBar: UINavigationBar!
    
    //UINavigationBarをステータスバーまで広げる
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    @IBAction func touchedScreenRecognizer(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    enum CategoryList: Int, CaseIterable {
        case store
        case place
        case genre
        
        var categoryTitle: String {
            switch self {
            case .store: return "店名"
            case .place: return "場所"
            case .genre: return "ジャンル"
            }
        }
        
        var categoryPlaceHolderList: String {
            switch self {
            case .store: return "例)サイゼリヤ"
            case .place: return "例)新宿"
            case .genre: return "例)イタリアン"
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
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.signupCell, for: indexPath) as! SignupCategoryTableViewCell
        let signupAndCancelButtonCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral
            .actionButtonCell, for: indexPath) as! CommonActionButtonTableViewCell
        
        categoryCell.delegate = self
        
        switch indexPath.row {
        case 0:
            categoryCell.categoryTitle = CategoryList.store.categoryTitle
            categoryCell.categoryPlaceHolder = CategoryList.store.categoryPlaceHolderList
            categoryCell.indexPathNumber = indexPath.row
            return categoryCell
        case 1:
            categoryCell.categoryTitle = CategoryList.place.categoryTitle
            categoryCell.categoryPlaceHolder = CategoryList.place.categoryPlaceHolderList
            categoryCell.indexPathNumber = indexPath.row
            return categoryCell
        case 2:
            categoryCell.categoryTitle = CategoryList.genre.categoryTitle
            categoryCell.categoryPlaceHolder = CategoryList.genre.categoryPlaceHolderList
            categoryCell.indexPathNumber = indexPath.row
            return categoryCell
        case 3:
            signupAndCancelButtonCell.delegate = self
            signupAndCancelButtonCell.setupButton(self)
            return signupAndCancelButtonCell
        default: break
        }
        return UITableViewCell()
    }
}

// MARK: -Protocol
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
        showSignupAlert()
    }
    
    func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Method
extension SignupViewController {
    private func setUpTableView() {
        tableView.dataSource = self
        let signupCategoryNib = UINib(nibName: NibNameLiteral.signupCategoryTableViewCell, bundle: nil)
        let signupAndCancelButtonCell = UINib(nibName: NibNameLiteral.commonActionButtonTableViewCell, bundle: nil)
        tableView.register(signupCategoryNib, forCellReuseIdentifier: CellIdentifierLiteral.signupCell)
        tableView.register(signupAndCancelButtonCell, forCellReuseIdentifier: CellIdentifierLiteral.actionButtonCell)
    }
    
    private func showSignupAlert() {
        let alert = UIAlertController(title: AlertTitleLiteral
            .signUp_2, message: nil, preferredStyle: .alert)
        let signupAction = UIAlertAction(title: AlertButtonLiteral.signUp, style: .default) { _ in
            self.textConvertNil()
            if self.storeNameString == nil, self.placeNameString == nil, self.genreNameString == nil {
                self.showAlertAllNilTextField()
            } else {
                let crudModel = StoreDataCrudModel()
                crudModel.createStoreData(store: self.storeNameString ?? "???", place: self.placeNameString ?? "???", genre: self.genreNameString ?? "???")
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        let cancelAction = UIAlertAction(title: AlertButtonLiteral.cancel, style: .cancel, handler: nil)
        alert.addAction(signupAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    //TFが""の場合Cellのレイアウトが崩れるため、nilを返して「???」を返す
    private func textConvertNil() {
        if storeNameString == "" {
            storeNameString = nil
        }
        if placeNameString == "" {
            placeNameString = nil
        }
        if genreNameString == "" {
            genreNameString = nil
        }
    }
}
