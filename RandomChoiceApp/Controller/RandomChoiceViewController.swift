//
//  ViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class RandomChoiceViewController: UIViewController, UITableViewDataSource {
    
    private let crudModel = StoreDataCrudModel()
    
    enum DiceScreenType: Int, CaseIterable {
        case result
        case dice
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crudModel.invalidAlertDelegate = self
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        crudModel.fetchStoreData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DiceScreenType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeDataCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.listPageCell) as! ListPageTableViewCell
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.randomChoiceButtonCell) as! RandomChoiceButtonTableViewCell
        
        guard let cellType = DiceScreenType(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch cellType {
        case .result:
            storeDataCell.storeDataText = ResultStoreDate.store
            storeDataCell.placeDataText = ResultStoreDate.place
            storeDataCell.genreDataText = ResultStoreDate.genre
            storeDataCell.isHiddenEditButton = true
            return storeDataCell
        case .dice:
            buttonCell.delegate = self
            return buttonCell
        }
    }
}

// MARK: -Protocol
extension RandomChoiceViewController: RandomChoiceButtonTableViewCellDelegate {
    func didTapDiceButton() {
        
        ResultStoreDataModel.showResultStoreData()
        
        tableView.reloadData()
    }
}

extension RandomChoiceViewController: InvalidAlertProtocal {
    func showAlertNoStoreData() {
        let alert = UIAlertController(title: AlertTitle.signUp_1, message: AlertMessage.signUp, preferredStyle: .alert)
        let signupAction = UIAlertAction(title: AlertButtonTitle.signUp, style: .default) { _ in
            self.performSegue(withIdentifier: SegueIdentifier.goToSignUpVC, sender: nil)
        }
        alert.addAction(signupAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: -Method
extension RandomChoiceViewController {
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: Nib.listPageTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.listPageCell)
        tableView.register(UINib(nibName: Nib.randomChoiceButtonTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.randomChoiceButtonCell)
    }
}

