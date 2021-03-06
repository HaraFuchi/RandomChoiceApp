//
//  DiceViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

final class DiceViewController: UIViewController {
    private enum DiceScreenType: Int, CaseIterable {
        case result, dice
    }

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.register(UINib(nibName: Nib.listPageTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.listPageCell)
            tableView.register(UINib(nibName: Nib.diceButtonTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.randomChoiceButtonCell)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        StoreDataManager.invalidAlertDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        StoreDataManager.fetchAll()
    }
}

/**********************************************************************/
// MARK: - Protocol
/**********************************************************************/
extension DiceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DiceScreenType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeDataCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.listPageCell) as! ListPageTableViewCell
        let diceCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.randomChoiceButtonCell) as! DiceButtonTableViewCell

        diceCell.buttonTapHandler = { _ in
            ExtractResultLogic.randomSelectedStoreData()
            tableView.reloadData()
        }

        guard let cellType = DiceScreenType(rawValue: indexPath.row) else { return UITableViewCell() }

        switch cellType {
        case .result:
            let item = ResultData.store
            storeDataCell.storeDataText = item?.store ?? Mark.questions
            storeDataCell.placeDataText = item?.place ?? Mark.questions
            storeDataCell.genreDataText = item?.genre ?? Mark.questions
            storeDataCell.isHiddenEditButton = true
            return storeDataCell
        case .dice:
            return diceCell
        }
    }
}

extension DiceViewController: InvalidAlertDisplayable {
    func showAlertNoStoreData() {
        let alert = UIAlertController(title: AlertTitle.signup1, message: AlertMessage.signUp, preferredStyle: .alert)
        let signupAction = UIAlertAction(title: AlertButtonTitle.signUp, style: .default) { _ in
            self.performSegue(withIdentifier: SegueIdentifier.goToSignUpVC, sender: nil)
        }
        alert.addAction(signupAction)
        present(alert, animated: true, completion: nil)
    }
}
