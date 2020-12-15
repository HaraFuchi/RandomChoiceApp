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
    private var resultStoreName = QuestionsLiteral.questions
    private var resultPlaceName = QuestionsLiteral.questions
    private var resultGenreName = QuestionsLiteral.questions
    
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeDataCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.listPageCell) as! ListPageTableViewCell
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.randomChoiceButtonCell) as! RandomChoiceButtonTableViewCell
        
        switch indexPath.row {
        case 0:
            storeDataCell.storeDataText = resultStoreName
            storeDataCell.placeDataText = resultPlaceName
            storeDataCell.genreDataText = resultGenreName
            storeDataCell.isHiddenEditButton = true
            return storeDataCell
        case 1:
            buttonCell.delegate = self
            return buttonCell
        default: break
        }
        return UITableViewCell()
    }
}

// MARK: -Protocol
extension RandomChoiceViewController: StoreDataCrudModelDelegate, RandomChoiceButtonTableViewCellDelegate {
    private var emptyNameText: String { return "???" }
    
    func didTapDiceButton() {
        let storeDataArray = crudModel.storeDataArray
        
        guard let element = storeDataArray.randomElement() else { return }
        
        resultStoreName = element.storeName ?? emptyNameText
        resultPlaceName = element.placeName ?? emptyNameText
        resultGenreName = element.genreName ?? emptyNameText
        
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

