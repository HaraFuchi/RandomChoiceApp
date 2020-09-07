//
//  ListViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let crudModel = StoreDataCrudModel()
    
    var indexPathNumber: Int? //CellのindexPathを保持
        
    @IBOutlet weak var signupVCBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
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
        cell.indexPathNumber = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        showDeleteAlert(tableView: tableView, editingStyle: editingStyle, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return AlertButtonLiteral.delete
    }
}

//MARK: - protocol
extension ListViewController: ListPageTableViewCellDelegate {
    func didTapEditButton(indexPath: Int) { //このindexPathの値をprepareに持っていきたい。
        indexPathNumber = indexPath
        performSegue(withIdentifier: "goToEditVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEditVC" {
            let editVC = segue.destination as! EditViewController
            if let indexPath = indexPathNumber {
                editVC.editStoreName = crudModel.storeDataArray[indexPath].storeName
                editVC.editPlaceName = crudModel.storeDataArray[indexPath].placeName
                editVC.editGenreName = crudModel.storeDataArray[indexPath].genreName
            }
        }
    }
}

//MARK: - Method
extension ListViewController {
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let listPageNib = UINib(nibName: "ListPageTableViewCell", bundle: nil)
        tableView.register(listPageNib, forCellReuseIdentifier: "ListPageCell")
    }
    
    private func showDeleteAlert(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, indexPath: IndexPath) {
        let showAlert = UIAlertController(title: AlertTitleLiteral.delete, message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: AlertButtonLiteral.delete, style: .destructive, handler: { _ -> Void in
            self.crudModel.deleteStoreInfo(indexPath: indexPath)
            if editingStyle == UITableViewCell.EditingStyle.delete {
                self.crudModel.storeDataArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            }
        })
        let cancelAction = UIAlertAction(title: AlertButtonLiteral.cancel, style: .cancel, handler: nil)
        showAlert.addAction(cancelAction)
        showAlert.addAction(deleteAction)
        present(showAlert, animated: true, completion: nil)
    }
}
