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
    let result = ResultStoreDataModel()
    
    enum DiceScreenType: Int, CaseIterable {
        case result
        case dice
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crudModel.delegate = self
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
        let storeDataCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.listPageCell) as! ListPageTableViewCell
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.randomChoiceButtonCell) as! RandomChoiceButtonTableViewCell
        
        guard let cellType = DiceScreenType(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch cellType {
        case .result:
            storeDataCell.storeDataText = result.resultStoreName
            storeDataCell.placeDataText = result.resultStoreName
            storeDataCell.genreDataText = result.resultStoreName
            storeDataCell.isHiddenEditButton = true
            return storeDataCell
        case .dice:
            buttonCell.delegate = self
            return buttonCell
        }
    }
}

// MARK: -Protocol
extension RandomChoiceViewController: StoreDataCrudModelDelegate, RandomChoiceButtonTableViewCellDelegate {
    func didTapDiceButton() {
        
        result.showResultStoreData()
        
        tableView.reloadData()
    }
    
    func showAlertNoStoreData() {
        let alert = UIAlertController(title: AlertTitleLiteral.signUp_1, message: AlertMessageLiteral.signUp, preferredStyle: .alert)
        let signupAction = UIAlertAction(title: AlertButtonLiteral.signUp, style: .default) { _ in
            self.performSegue(withIdentifier: SegueIdentifierLiteral.goToSignUpVC, sender: nil)
        }
        alert.addAction(signupAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: -Method
extension RandomChoiceViewController {
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: NibNameLiteral.listPageTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifierLiteral.listPageCell)
        tableView.register(UINib(nibName: NibNameLiteral.randomChoiceButtonTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifierLiteral.randomChoiceButtonCell)
    }
}

