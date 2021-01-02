//
//  EditViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/08/28.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITableViewDataSource, UINavigationBarDelegate, AlertDisplayable{
    
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
        let signupAndCancelButtonCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.actionButtonCell, for: indexPath) as! CommonActionButtonTableViewCell
        
        guard let cellType = CategoryListType(rawValue: indexPath.row) else { return UITableViewCell() }
        
        convertValueNil()
        
        categoryCell.delegate = self
        
        switch cellType {
        case .store:
            categoryCell.categoryTitle = CategoryListType.store.title ?? ""
            categoryCell.categoryText = editStoreNameString ?? ""
            categoryCell.cellType = .store
            return categoryCell
        case .place:
            categoryCell.categoryTitle = CategoryListType.place.title ?? ""
            categoryCell.categoryText = editPlaceNameString ?? ""
            categoryCell.cellType = .place
            return categoryCell
        case .genre:
            categoryCell.categoryTitle = CategoryListType.genre.title ?? ""
            categoryCell.categoryText = editGenreNameString ?? ""
            categoryCell.cellType = .genre
            return categoryCell
        case .signup:
            signupAndCancelButtonCell.delegate = self
            signupAndCancelButtonCell.setupButton(self)
            return signupAndCancelButtonCell
        }
    }
}

//MARK: - Protocol
extension EditViewController: SignupCategoryTableViewCellDelegate, CommonActionButtonTableViewCellDelegate {
    func fetchCategoryNameText(textField: UITextField, cellType: CategoryListType) {
        switch cellType {
        case .store: editStoreNameString = textField.text
        case .place: editPlaceNameString = textField.text
        case .genre: editGenreNameString = textField.text
        case .signup: break
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
    //TFが""の場合Cellのレイアウトが崩れるため、nilを返して「???」を返す
    private func convertValueNil() {
        if editStoreNameString == QuestionsLiteral.questions || editStoreNameString == "" {
            editStoreNameString = nil
        }
        if editPlaceNameString == QuestionsLiteral.questions || editPlaceNameString == "" {
            editPlaceNameString = nil
        }
        if editGenreNameString == QuestionsLiteral.questions || editGenreNameString == "" {
            editGenreNameString = nil
        }
    }
    
    private func showEditAlert() {
        let alert = UIAlertController(title: AlertTitle.edit, message: nil, preferredStyle: .alert)
        let editAction = UIAlertAction(title: AlertButtonTitle.save, style: .default) { _ in
            //Firebaseの更新機能追加
            self.convertValueNil()
            self.editAction()
        }
        let cancelAction = UIAlertAction(title: AlertButtonTitle.cancel, style: .cancel, handler: nil)
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func editAction() {
        if editStoreNameString == nil, editPlaceNameString == nil, editGenreNameString == nil {
            showAlertAllNilTextField()
        } else {
            crudModel.editStoreData(store: editStoreNameString ?? emptyNameText, place: editPlaceNameString ?? emptyNameText, genre: editGenreNameString ?? emptyNameText, childID: childID)
            dismiss(animated: true, completion: nil)
        }
    }
}
