//
//  SignupViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITableViewDataSource, UINavigationBarDelegate, AlertDisplayable {

    // 登録する内容の値を保持
    private var storeNameString: String?
    private var placeNameString: String?
    private var genreNameString: String?

    @IBOutlet private weak var navigationBar: UINavigationBar!

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            let signupCategoryNib = UINib(nibName: Nib.signupCategoryTableViewCell, bundle: nil)
            let signupAndCancelButtonCell = UINib(nibName: Nib.commonActionButtonTableViewCell, bundle: nil)
            tableView.register(signupCategoryNib, forCellReuseIdentifier: CellIdentifier.signupCell)
            tableView.register(signupAndCancelButtonCell, forCellReuseIdentifier: CellIdentifier.actionButtonCell)
        }
    }

    // UINavigationBarをステータスバーまで広げる
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

    @IBAction func touchedScreenRecognizer(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
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

        actionButtonCell.signupButtonTapHandler = { [weak self] _ in
            self?.showSignupAlert()
        }

        switch cellType {
        case .store:
            categoryCell.categoryTitle = CategoryListType.store.title
            categoryCell.categoryPlaceHolder = CategoryListType.store.placeHolder
            categoryCell.cellType = .store
            return categoryCell
        case .place:
            categoryCell.categoryTitle = CategoryListType.place.title
            categoryCell.categoryPlaceHolder = CategoryListType.place.placeHolder
            categoryCell.cellType = .place
            return categoryCell
        case .genre:
            categoryCell.categoryTitle = CategoryListType.genre.title
            categoryCell.categoryPlaceHolder = CategoryListType.genre.placeHolder
            categoryCell.cellType = .genre
            return categoryCell
        case .signup:
            actionButtonCell.setupButton(self)
            actionButtonCell.delegate = self
            return actionButtonCell
        }
    }
}

// MARK: - Protocol
extension SignupViewController: SignupCategoryTableViewCellDelegate {
    func fetchCategoryNameText(textField: UITextField, cellType: CategoryListType) {
        switch cellType {
        case .store: storeNameString = textField.text
        case .place: placeNameString = textField.text
        case .genre: genreNameString = textField.text
        case .signup: break
        }
    }
}

extension SignupViewController: actionButtonProtocal {
    func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Method
extension SignupViewController {
    private func showSignupAlert() {
        let alert = UIAlertController(title: AlertTitle.signup2, message: nil, preferredStyle: .alert)
        let signupAction = UIAlertAction(title: AlertButtonTitle.signUp, style: .default) { _ in
            self.textConvertNil()
            if self.storeNameString == nil, self.placeNameString == nil, self.genreNameString == nil {
                self.showAlertAllNilTextField()
            } else {
                let crudModel = StoreDataManager()
                crudModel.createStoreData(store: self.storeNameString ?? "???", place: self.placeNameString ?? "???", genre: self.genreNameString ?? "???")
                self.dismiss(animated: true, completion: nil)
            }

        }
        let cancelAction = UIAlertAction(title: AlertButtonTitle.cancel, style: .cancel, handler: nil)
        alert.addAction(signupAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    // TFが""の場合Cellのレイアウトが崩れるため、nilを返して「???」を返す
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
