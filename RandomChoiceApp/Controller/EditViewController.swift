//
//  EditViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/08/28.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITableViewDataSource, UINavigationBarDelegate, AlertDisplayable{
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            let singUpCategoryNib = UINib(nibName: Nib.signupCategoryTableViewCell, bundle: nil)
            let signupAndCancelButtonCell = UINib(nibName: Nib.commonActionButtonTableViewCell, bundle: nil)
            tableView.register(singUpCategoryNib, forCellReuseIdentifier: CellIdentifier.signupCell)
            tableView.register(signupAndCancelButtonCell, forCellReuseIdentifier: CellIdentifier.actionButtonCell)
        }
    }
    
    let crudModel = StoreDataCrudModel()
    var storeData: StoreData?
    
    //UINavigationBarをステータスバーまで広げる
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryListType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.signupCell, for: indexPath) as! SignupCategoryTableViewCell
        let actionButtonCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.actionButtonCell, for: indexPath) as! CommonActionButtonTableViewCell
        
        guard let cellType = CategoryListType(rawValue: indexPath.row) else { return UITableViewCell() }
        
        categoryCell.delegate = self
        
        convertValueNil()
        
        actionButtonCell.signupButtonTapHandler = { [weak self] _ in
            self?.showEditAlert()
        }
        
        switch cellType {
        case .store:
            categoryCell.categoryTitle = CategoryListType.store.title ?? ""
            categoryCell.categoryText = storeData?.store ?? ""
            categoryCell.cellType = .store
            return categoryCell
        case .place:
            categoryCell.categoryTitle = CategoryListType.place.title ?? ""
            categoryCell.categoryText = storeData?.place ?? ""
            categoryCell.cellType = .place
            return categoryCell
        case .genre:
            categoryCell.categoryTitle = CategoryListType.genre.title ?? ""
            categoryCell.categoryText = storeData?.genre ?? ""
            categoryCell.cellType = .genre
            return categoryCell
        case .signup:
            actionButtonCell.setupButton(self)
            actionButtonCell.delegate = self
            return actionButtonCell
        }
    }
}

//MARK: - Protocol
extension EditViewController: SignupCategoryTableViewCellDelegate {
    func fetchCategoryNameText(textField: UITextField, cellType: CategoryListType) {
        switch cellType {
        case .store: storeData?.store = textField.text ?? ""
        case .place: storeData?.place = textField.text ?? ""
        case .genre: storeData?.genre = textField.text ?? ""
        case .signup: break
        }
    }
}

extension EditViewController: actionButtonProtocal {
    func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Method
extension EditViewController {
    // TFに???を反映させる必要はないため、nilを返す
    // TFが""の場合Cellのレイアウトが崩れるため、nilを返して「???」を返す
    private func convertValueNil() {
        if storeData?.store == Mark.questions || storeData?.store == "" {
            storeData?.store = nil
        }
        if storeData?.place == Mark.questions || storeData?.place == "" {
            storeData?.place = nil
        }
        if storeData?.genre == Mark.questions || storeData?.genre == "" {
            storeData?.genre = nil
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
        if storeData?.store == nil, storeData?.place == nil, storeData?.genre == nil {
            showAlertAllNilTextField()
        } else {
            crudModel.editStoreData(store: storeData?.store ?? Mark.questions,
                                    place: storeData?.place ?? Mark.questions,
                                    genre: storeData?.genre ?? Mark.questions,
                                    childID: storeData?.childID)
            dismiss(animated: true, completion: nil)
        }
    }
}
