//
//  SignupViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

final class SignupViewController: UIViewController, AlertDisplayable {

    private var storeData = StoreData(childID: nil)

    @IBOutlet private weak var navigationBar: UINavigationBar! {
        didSet {
            navigationBar.delegate = self
        }
    }

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.dataSource = self

            let signupCategoryNib = UINib(nibName: SignupCategoryTableViewCell.className, bundle: nil)
            let signupAndCancelButtonCell = UINib(nibName: SignupButtonTableViewCell.className, bundle: nil)

            tableView.register(signupCategoryNib, forCellReuseIdentifier: SignupCategoryTableViewCell.className)
            tableView.register(signupAndCancelButtonCell, forCellReuseIdentifier: SignupButtonTableViewCell.className)
        }
    }

    @IBAction func touchedScreenRecognizer(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    /**********************************************************************/
    // MARK: - Private Method
    /**********************************************************************/
    private func showSignupAlert() {
        let alert = UIAlertController(title: AlertTitle.signup2, message: nil, preferredStyle: .alert)
        let signupAction = UIAlertAction(title: AlertButtonTitle.signUp, style: .default) { _ in
            self.textConvertToNilIfNeeded()
            if self.storeData.store == nil, self.storeData.place == nil, self.storeData.genre == nil {
                self.showAlertAllNilTextField()
            } else {

                StoreDataManager.create(store: self.storeData.store ?? Mark.questions,
                                        place: self.storeData.place ?? Mark.questions,
                                        genre: self.storeData.genre ?? Mark.questions)
                self.dismiss(animated: true, completion: nil)
            }

        }
        let cancelAction = UIAlertAction(title: AlertButtonTitle.cancel, style: .cancel, handler: nil)
        alert.addAction(signupAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    // TFが""の場合Cellのレイアウトが崩れるため、「???」を入れる
    // TODO: Converterクラスを作成
    private func textConvertToNilIfNeeded() {
        if storeData.store.isEmptyOrNil {
            storeData.store = Mark.questions
        }

        if storeData.place.isEmptyOrNil {
            storeData.place = Mark.questions
        }

        if storeData.genre.isEmptyOrNil {
            storeData.genre = Mark.questions
        }
    }
}

/**********************************************************************/
// MARK: - Protocol
/**********************************************************************/
extension SignupViewController: UINavigationBarDelegate {
    // UINavigationBarをステータスバーまで広げる
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        .topAttached
    }
}

extension SignupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CategoryListType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: SignupCategoryTableViewCell.className, for: indexPath) as? SignupCategoryTableViewCell,
              let actionCell = tableView.dequeueReusableCell(withIdentifier: SignupButtonTableViewCell.className, for: indexPath) as? SignupButtonTableViewCell else { return UITableViewCell() }

        categoryCell.delegate = self

        actionCell.signupButtonTapHandler = { [weak self] _ in
            self?.showSignupAlert()
        }

        actionCell.cancelButtonTapHandler = { _ in
            self.dismiss(animated: true, completion: nil)
        }

        guard let cellType = CategoryListType(rawValue: indexPath.row) else { return UITableViewCell() }

        switch cellType {
        case .store:
            categoryCell.setText(title: CategoryListType.store.title,
                                 placeHolder: CategoryListType.store.placeHolder,
                                 cellType: .store)
            return categoryCell
        case .place:
            categoryCell.setText(title: CategoryListType.place.title,
                                 placeHolder: CategoryListType.place.placeHolder,
                                 cellType: .place)
            return categoryCell
        case .genre:
            categoryCell.setText(title: CategoryListType.genre.title,
                                 placeHolder: CategoryListType.genre.placeHolder,
                                 cellType: .genre)
            return categoryCell
        case .signup:
            actionCell.setupButton(self)
            return actionCell
        }
    }
}

extension SignupViewController: SignupCategoryViewDelegate {
    func textField(_ textField: UITextField, cellType categoryListType: CategoryListType) {
        switch categoryListType {
        case .store: storeData.store = textField.text
        case .place: storeData.place = textField.text
        case .genre: storeData.genre = textField.text
        case .signup: break
        }
    }
}
