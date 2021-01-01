//
//  ListViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit
import SkeletonView
import Reachability

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SkeletonTableViewDataSource {
    
    private let crudModel = StoreDataCrudModel()
    private var indexPathNumber: Int? //CellのindexPathを保持
    
    @IBOutlet private weak var signupVCBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        crudModel.fetchStoreData(tableView: tableView)
        checkNetworkStatus()
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
            cell.storeDataText = crudModel.storeDataArray[indexPath.row].storeName ?? "???"
            cell.placeDataText = crudModel.storeDataArray[indexPath.row].placeName ?? "???"
            cell.genreDataText = crudModel.storeDataArray[indexPath.row].genreName ?? "???"
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

//MARK: - Private Method
private extension ListViewController {
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let listPageNib = UINib(nibName: NibNameLiteral.listPageTableViewCell, bundle: nil)
        tableView.register(listPageNib, forCellReuseIdentifier: CellIdentifierLiteral.listPageCell)
    }
    
    func showDeleteAlert(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, indexPath: IndexPath) {
        let showAlert = UIAlertController(title: AlertTitleLiteral.delete, message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: AlertButtonLiteral.delete, style: .destructive, handler: { _ -> Void in
            self.crudModel.deleteStoreData(indexPath: indexPath)
        })
        let cancelAction = UIAlertAction(title: AlertButtonLiteral.cancel, style: .cancel, handler: nil)
        showAlert.addAction(cancelAction)
        showAlert.addAction(deleteAction)
        present(showAlert, animated: true, completion: nil)
    }
    
    //オフラインの際に出すアラート
    func showAlertOffline() {
        let alert = UIAlertController(title: AlertTitleLiteral.error, message: AlertMessageLiteral.offline, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: AlertButtonLiteral.OK, style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func checkNetworkStatus() {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            // インターネット接続なし
            showAlertOffline()
        }
    }
    
    func setUpSkeleton(cell: ListPageTableViewCell) {
        //スケルトンの色を設定
        let gradient = SkeletonGradient(baseColor: .clouds)
        cell.showAnimatedGradientSkeleton(usingGradient: gradient, transition: .crossDissolve(0.25))
    }
}
