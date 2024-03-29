//
//  EditViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/08/28.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

final class EditViewController: UIViewController, AlertDisplayable {
    var storeData: StoreData?

    @IBOutlet weak var navigationBar: UINavigationBar! {
        didSet {
            navigationBar.delegate = self
        }
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            let singupCategoryNib = UINib(nibName: SignupCategoryTableViewCell.className, bundle: nil)
            let signupAndCancelButtonCell = UINib(nibName: SignupButtonTableViewCell.className, bundle: nil)

            tableView.register(singupCategoryNib, forCellReuseIdentifier: SignupCategoryTableViewCell.className)
            tableView.register(signupAndCancelButtonCell, forCellReuseIdentifier: SignupButtonTableViewCell.className)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // **********************************************************************/
    // MARK: - Private Method
    // **********************************************************************/
    private func convertToQuestionsIfNeeded() {
        if storeData?.store == "" {
            storeData?.store = Mark.questions
        }
        if storeData?.place == "" {
            storeData?.place = Mark.questions
        }
        if storeData?.genre == "" {
            storeData?.genre = Mark.questions
        }
    }

    private func convertToNilIfNeeded() {
        if storeData?.store == Mark.questions {
            storeData?.store = nil
        }

        if storeData?.place == Mark.questions {
            storeData?.place = nil
        }

        if storeData?.genre == Mark.questions {
            storeData?.genre = nil
        }
    }

    private func showEditAlert() {
        let alert = UIAlertController(title: AlertTitle.edit, message: nil, preferredStyle: .alert)
        let editAction = UIAlertAction(title: AlertButtonTitle.save, style: .default) { _ in
            self.convertToQuestionsIfNeeded()
            if self.storeData?.store == nil, self.storeData?.place == nil, self.storeData?.genre == nil {
                self.showAlertAllNilTextField()
            }

            self.editAction()
        }
        let cancelAction = UIAlertAction(title: AlertButtonTitle.cancel, style: .cancel, handler: nil)
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    private func editAction() {
        guard let uniqID = storeData?.childID else { return }

        StoreDataManager.update(uniqID: uniqID,
                                store: storeData?.store ?? Mark.questions,
                                place: storeData?.place ?? Mark.questions,
                                genre: storeData?.genre ?? Mark.questions)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Protocol
extension EditViewController: UINavigationBarDelegate {
    // UINavigationBarをステータスバーまで広げる
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension EditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CategoryListType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: SignupCategoryTableViewCell.className, for: indexPath) as? SignupCategoryTableViewCell,
              let actionCell = tableView.dequeueReusableCell(withIdentifier: SignupButtonTableViewCell.className, for: indexPath) as? SignupButtonTableViewCell else { return UITableViewCell() }

        categoryCell.delegate = self

        convertToNilIfNeeded()

        actionCell.signupButtonTapHandler = { [weak self] _ in
            self?.showEditAlert()
        }

        actionCell.cancelButtonTapHandler = { _ in
            self.dismiss(animated: true, completion: nil)
        }

        guard let cellType = CategoryListType(rawValue: indexPath.row) else { return UITableViewCell() }

        switch cellType {
        case .store:
            categoryCell.setText(title: CategoryListType.store.title,
                                 data: storeData?.store,
                                 cellType: .store)
            return categoryCell
        case .place:
            categoryCell.setText(title: CategoryListType.place.title,
                                 data: storeData?.place,
                                 cellType: .place)
            return categoryCell
        case .genre:
            categoryCell.setText(title: CategoryListType.genre.title,
                                 data: storeData?.genre,
                                 cellType: .genre)
            return categoryCell
        case .signup:
            actionCell.setupButton(self)
            return actionCell
        }
    }
}

extension EditViewController: SignupCategoryViewDelegate {
    func textField(_ textField: UITextField, cellType categoryListType: CategoryListType) {
        switch categoryListType {
        case .store: storeData?.store = textField.text
        case .place: storeData?.place = textField.text
        case .genre: storeData?.genre = textField.text
        case .signup: break
        }
    }
}
