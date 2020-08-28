//
//  ListViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let crudModel = StoreDataCrudModel()
    
    @IBOutlet weak var signupVCBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let listPageNib = UINib(nibName: "ListPageTableViewCell", bundle: nil)
        tableView.register(listPageNib, forCellReuseIdentifier: "ListPageCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        crudModel.fetchStoreData(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crudModel.storeDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPageCell", for: indexPath) as! ListPageTableViewCell
        cell.delegate = self
        cell.storeNameLabel.text = crudModel.storeDataArray[indexPath.row].storeName
        cell.placeLabel.text = crudModel.storeDataArray[indexPath.row].placeName
        cell.genreLabel.text = crudModel.storeDataArray[indexPath.row].genreName
        return cell
    }
    
    //セルの編集許可(スワイプを可能にする)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        showDeleteAlert(tableView: tableView, editingStyle: editingStyle, indexpath: indexPath)
    }
}

//MARK: - Private func
extension ListViewController {
    private func showDeleteAlert(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, indexpath: IndexPath) {
        let showAlert = UIAlertController(title: "お店一覧から削除しますか？", message: "", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "削除", style: .destructive, handler: { _ -> Void in
            self.crudModel.deleteStoreInfo(indexpath: indexpath)
            if editingStyle == UITableViewCell.EditingStyle.delete {
                self.crudModel.storeDataArray.remove(at: indexpath.row)
                tableView.deleteRows(at: [indexpath as IndexPath], with: UITableView.RowAnimation.automatic)
            }
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { _ -> Void in
        })
        showAlert.addAction(cancelAction)
        showAlert.addAction(deleteAction)
        present(showAlert, animated: true, completion: nil)
    }
}
//MARK: - protocol

extension ListViewController: ListPageTableViewCellDelegate {
    
    func didTapEditButton() {
        performSegue(withIdentifier: "goToEditVC", sender: nil)
    }
}
