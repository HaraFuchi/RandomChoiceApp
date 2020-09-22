//
//  ViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class RandomChoiceViewController: UIViewController, UITableViewDataSource {
    
    let crudModel = StoreDataCrudModel()
    var resultStoreName = LiteralQuestions.questions
    var resultPlaceName = LiteralQuestions.questions
    var resultGenreName = LiteralQuestions.questions
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crudModel.delegate = self
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        crudModel.fetchStoreData(tableView: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeDataCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.listPageViewCell) as! ListPageTableViewCell
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.randomChoiceButtonCell) as! RandomChoiceButtonTableViewCell
        
        switch indexPath.row {
        case 0:
            storeDataCell.storeNameLabel.text = resultStoreName
            storeDataCell.placeLabel.text = resultPlaceName
            storeDataCell.genreLabel.text = resultGenreName
            storeDataCell.editButton.isHidden = true
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
    func didTapDiceButton() {
        let storeDataArray = crudModel.storeDataArray
        let element = storeDataArray.randomElement()
        
        guard let _ = element else { return }
        
        resultStoreName = element?.storeName ?? "???"
        resultPlaceName = element?.placeName ?? "???"
        resultGenreName = element?.genreName ?? "???"
        
        tableView.reloadData()
    }
    
    func showNoStoreDataAlert() {
        let alert = UIAlertController(title: AlertTitleLiteral.signUp_1, message: AlertMessageLiteral.signUp, preferredStyle: .alert)
        let signupAction = UIAlertAction(title: AlertButtonLiteral.signUp, style: .default) { _ in
            self.performSegue(withIdentifier: SegueIdentifierLiteral.goToSignUpVC, sender: nil)
        }
        alert.addAction(signupAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifierLiteral.goToSignUpVC {
            let signupVC = segue.destination as! SignupViewController
            if crudModel.storeDataArray.isEmpty {
                signupVC.isHiddenCancelButton = true
            }
        }
    }
}

// MARK: -Method
extension RandomChoiceViewController {
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: NibNameLiteral.listPageTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifierLiteral.listPageViewCell)
        tableView.register(UINib(nibName: NibNameLiteral.randomChoiceButtonTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifierLiteral.randomChoiceButtonCell)
    }
}

