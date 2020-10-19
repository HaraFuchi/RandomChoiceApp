//
//  ListViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit
import SkeletonView

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SkeletonTableViewDataSource {
    
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
        if crudModel.storeDataArray.isEmpty {
            let skeletonCellNum = 10
            return skeletonCellNum
        } else {
            return crudModel.storeDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.listPageCell, for: indexPath) as! ListPageTableViewCell
        cell.delegate = self
        
        if crudModel.storeDataArray.isEmpty {
            setUpSkeleton(cell: cell)
        } else {
            cell.hideSkeleton()
            cell.storeNameLabel.text = crudModel.storeDataArray[indexPath.row].storeName
            cell.placeLabel.text = crudModel.storeDataArray[indexPath.row].placeName
            cell.genreLabel.text = crudModel.storeDataArray[indexPath.row].genreName
            cell.indexPathNumber = indexPath.row
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        showDeleteAlert(tableView: tableView, editingStyle: editingStyle, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //スケルトンビュー表示時はセルをスワイプ不可にする
        if crudModel.storeDataArray.isEmpty {
            return UITableViewCell.EditingStyle.none
        } else {
            return UITableViewCell.EditingStyle.delete
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return AlertButtonLiteral.delete
    }
    
    //スケルトンビュー対象セルのReusableCellIdentifierを登録
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CellIdentifierLiteral.listPageCell
    }
}

//MARK: - protocol
extension ListViewController: ListPageTableViewCellDelegate {
    
    func didTapEditButton(indexPath: Int) {
        indexPathNumber = indexPath
        performSegue(withIdentifier: SegueIdentifierLiteral.goToEditVC, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifierLiteral.goToEditVC {
            let editVC = segue.destination as! EditViewController
            if let indexPath = indexPathNumber {
                editVC.editStoreNameString = crudModel.storeDataArray[indexPath].storeName
                editVC.editPlaceNameString = crudModel.storeDataArray[indexPath].placeName
                editVC.editGenreNameString = crudModel.storeDataArray[indexPath].genreName
                editVC.childID = crudModel.storeDataArray[indexPath].childID
            }
        }
    }
}

//MARK: - Method
extension ListViewController {
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let listPageNib = UINib(nibName: NibNameLiteral.listPageTableViewCell, bundle: nil)
        tableView.register(listPageNib, forCellReuseIdentifier: CellIdentifierLiteral.listPageCell)
    }
    
    private func showDeleteAlert(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, indexPath: IndexPath) {
        let showAlert = UIAlertController(title: AlertTitleLiteral.delete, message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: AlertButtonLiteral.delete, style: .destructive, handler: { _ -> Void in
            self.crudModel.deleteStoreData(indexPath: indexPath)
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
    
    private func setUpSkeleton(cell: ListPageTableViewCell) {
        //スケルトンの色を設定
        let gradient = SkeletonGradient(baseColor: .clouds)
        cell.showAnimatedGradientSkeleton(usingGradient: gradient, transition: .crossDissolve(0.25))
    }
}
