//
//  ViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class RandomChoiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let crudModel = StoreDataCrudModel()
    var resultStoreName = LiteralQuestions.questions
    var resultPlaceName = LiteralQuestions.questions
    var resultGenreName = LiteralQuestions.questions
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crudModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListPageTableViewCell", bundle: nil), forCellReuseIdentifier: "ListPageViewCell")
        tableView.register(UINib(nibName: "RandomChoiceButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "RandomChoiceButtonCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        crudModel.fetchStoreData(tableView: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeDataCell = tableView.dequeueReusableCell(withIdentifier: "ListPageViewCell") as! ListPageTableViewCell
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: "RandomChoiceButtonCell") as! RandomChoiceButtonTableViewCell
        
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

// MARK: -protocol
extension RandomChoiceViewController: StoreDataCrudModelDelegate, RandomChoiceButtonTableViewCellDelegate {
    func didTapDiceButton() {
        //FIXME:データを取ってくる前にタップするとnilが帰ってくるためリファクタリングが必要
        let storeDataArray = crudModel.storeDataArray
        let element = storeDataArray.randomElement()
        
        resultStoreName = (element?.storeName ?? "???") as String
        resultPlaceName = (element?.placeName ?? "???") as String
        resultGenreName = (element?.genreName ?? "???") as String
        
        tableView.reloadData()
    }
    
    func showNoStoreDataAlert() {
        let alert = UIAlertController(title: AlertTitleLiteral.signUp_1, message: AlertMessageLiteral.signUp, preferredStyle: .alert)
        let signupAction = UIAlertAction(title: AlertButtonLiteral.signUp, style: .default) { _ in
            self.performSegue(withIdentifier: "goToSignupVC", sender: nil)
        }
        alert.addAction(signupAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSignupVC" {
            let signupVC = segue.destination as! SignupViewController
            if crudModel.storeDataArray.isEmpty == true {
                signupVC.isHiddenCancelButton = true
            }
        }
    }
}

