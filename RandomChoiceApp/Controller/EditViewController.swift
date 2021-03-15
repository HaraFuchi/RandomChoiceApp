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
            let singUpCategoryNib = UINib(nibName: Nib.signupCategoryTableViewCell, bundle: nil)
            let signupAndCancelButtonCell = UINib(nibName: Nib.signupButtonTableViewCell, bundle: nil)
            tableView.register(singUpCategoryNib, forCellReuseIdentifier: CellIdentifier.signupCell)
            tableView.register(signupAndCancelButtonCell, forCellReuseIdentifier: CellIdentifier.actionButtonCell)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private Method
    // TODO: converterクラスを作成してModel化
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
            self.convertValueNil()
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
        return CategoryListType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.signupCell, for: indexPath) as! SignupCategoryTableViewCell
        let actionCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.actionButtonCell, for: indexPath) as! SignupButtonTableViewCell

        categoryCell.delegate = self

        convertValueNil()

        actionCell.signupButtonTapHandler = { [weak self] _ in
            self?.showEditAlert()
        }

        actionCell.cancelButtonTapHandler = { _ in
            self.dismiss(animated: true, completion: nil)
        }

        guard let cellType = CategoryListType(rawValue: indexPath.row) else { return UITableViewCell() }

        switch cellType {
        case .store:
            categoryCell.categoryTitle = CategoryListType.store.title
            categoryCell.categoryText = storeData?.store
            categoryCell.cellType = .store
            return categoryCell
        case .place:
            categoryCell.categoryTitle = CategoryListType.place.title
            categoryCell.categoryText = storeData?.place
            categoryCell.cellType = .place
            return categoryCell
        case .genre:
            categoryCell.categoryTitle = CategoryListType.genre.title
            categoryCell.categoryText = storeData?.genre
            categoryCell.cellType = .genre
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
