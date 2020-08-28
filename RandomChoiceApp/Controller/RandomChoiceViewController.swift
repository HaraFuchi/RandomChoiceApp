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
    var resultStoreName = "???"
    var resultPlaceName = "???"
    var resultGenreName = "???"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crudModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListPageTableViewCell", bundle: nil), forCellReuseIdentifier: "ListPagewCell")
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
        let storeDataCell = tableView.dequeueReusableCell(withIdentifier: "ListPagewCell") as! ListPageTableViewCell
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: "RandomChoiceButtonCell") as! RandomChoiceButtonTableViewCell
        
        switch indexPath.row {
        case 0:
            storeDataCell.storeNameLabel.text = resultStoreName
            storeDataCell.placeLabel.text = resultPlaceName
            storeDataCell.genreLabel.text = resultGenreName
            return storeDataCell
        case 1:
            buttonCell.delegate = self
            return buttonCell
        default:
            break
        }
        return UITableViewCell()
    }
}

// MARK: -protcol
extension RandomChoiceViewController: StoreDataCrudModelDelegate, RandomChoiceButtonTableViewCellDelegate {
    func didTapDiceButton() {
        let storeDataArray = crudModel.storeDataArray
        if storeDataArray.isEmpty == true {
            //FIXME:アラートではなく、さいころのプロパティを変えるのが理想
            showErrorAlert()
        } else {
            let element = storeDataArray.randomElement()
            resultStoreName = (element?.storeName ?? "???") as String
            resultPlaceName = (element?.placeName ?? "???") as String
            resultGenreName = (element?.genreName ?? "???") as String
            tableView.reloadData()
        }
    }
    
    func showNoStoreDataAlert() {
        let alert = UIAlertController(title: "よく行くお店を登録しよう", message: "お店がまだ登録されていません", preferredStyle: .alert)
        let signupAction = UIAlertAction(title: "登録する", style: .default) { _ in
            self.performSegue(withIdentifier: "goToSignupVC", sender: nil)
        }
        alert.addAction(signupAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "もう一度さいころを押してください", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

