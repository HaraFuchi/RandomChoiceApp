//
//  SignupViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITableViewDataSource, AlertDisplayable{
    
    //登録する内容の値を保持
    private var storeNameString: String?
    private var placeNameString: String?
    private var genreNameString: String?
        
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private weak var navigationBar: UINavigationBar!
    
    @IBAction func touchedScreenRecognizer(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        navigationBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryListType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.signupCell, for: indexPath) as! SignupCategoryTableViewCell
        let signupAndCancelButtonCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral
            .actionButtonCell, for: indexPath) as! CommonActionButtonTableViewCell
        
        guard let cellType = CategoryListType(rawValue: indexPath.row) else { return UITableViewCell() }
        
        categoryCell.delegate = self
        
        switch cellType {
        case .store:
            categoryCell.categoryTitle = CategoryListType.store.title ?? ""
            categoryCell.categoryPlaceHolder = CategoryListType.store.placeHolder ?? ""
            categoryCell.indexPathNumber = indexPath.row
            return categoryCell
        case .place:
            categoryCell.categoryTitle = CategoryListType.place.title ?? ""
            categoryCell.categoryPlaceHolder = CategoryListType.place.placeHolder ?? ""
            categoryCell.indexPathNumber = indexPath.row
            return categoryCell
        case .genre:
            categoryCell.categoryTitle = CategoryListType.genre.title ?? ""
            categoryCell.categoryPlaceHolder = CategoryListType.genre.placeHolder ?? ""
            categoryCell.indexPathNumber = indexPath.row
            return categoryCell
        case .signup:
            signupAndCancelButtonCell.delegate = self
            signupAndCancelButtonCell.setupButton(self)
            return signupAndCancelButtonCell
        }
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
