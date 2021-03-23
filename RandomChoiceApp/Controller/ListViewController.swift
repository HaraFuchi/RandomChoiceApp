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

final class ListViewController: UIViewController, SkeletonTableViewDataSource {
    var storeData: StoreData?

    @IBOutlet private weak var signupVCBarButtonItem: UIBarButtonItem!

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            let listPageNib = UINib(nibName: Nib.listPageTableViewCell, bundle: nil)
            tableView.register(listPageNib, forCellReuseIdentifier: CellIdentifier.listPageCell)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        StoreDataManager.fetchAll {
            self.tableView.reloadData()
        }
        checkNetworkStatus()
    }

    // スケルトンビュー対象セルのReusableCellIdentifierを登録
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CellIdentifier.listPageCell
    }

    // MARK: - Private Method
    private func showDeleteAlert(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, indexPath: IndexPath) {
        let showAlert = UIAlertController(title: AlertTitle.delete, message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: AlertButtonTitle.delete, style: .destructive) { ( _ ) in
            let data = StoreDataManager.storeDataList[indexPath.row]
            StoreDataManager.delete(at: data)

            guard StoreDataManager.storeDataList.isEmpty else { return }

            if editingStyle == UITableViewCell.EditingStyle.delete {
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            }
        }
        let cancelAction = UIAlertAction(title: AlertButtonTitle.cancel, style: .cancel, handler: nil)
        showAlert.addAction(cancelAction)
        showAlert.addAction(deleteAction)
        present(showAlert, animated: true, completion: nil)
    }

    // オフラインの際に出すアラート
    private func showAlertOffline() {
        let alert = UIAlertController(title: AlertTitle.error, message: AlertMessage.offline, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: AlertButtonTitle.ok, style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }

    private func checkNetworkStatus() {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            // インターネット接続なし
            showAlertOffline()
        }
    }

    private func setUpSkeleton(cell: ListPageTableViewCell) {
        // スケルトンの色を設定
        let gradient = SkeletonGradient(baseColor: .clouds)
        cell.showAnimatedGradientSkeleton(usingGradient: gradient, transition: .crossDissolve(0.25))
    }
}

// MARK: - protocol
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if StoreDataManager.storeDataList.isEmpty {
            let skeletonCellNum = 10
            return skeletonCellNum
        } else {
            return StoreDataManager.storeDataList.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.listPageCell, for: indexPath) as! ListPageTableViewCell
        cell.delegate = self

        if StoreDataManager.storeDataList.isEmpty {
            setUpSkeleton(cell: cell)
        } else {
            cell.hideSkeleton()
            cell.storeData = StoreDataManager.storeDataList[indexPath.row]
        }
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        showDeleteAlert(tableView: tableView, editingStyle: editingStyle, indexPath: indexPath)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // スケルトンビュー表示時はセルをスワイプ不可にする
        if StoreDataManager.storeDataList.isEmpty {
            return UITableViewCell.EditingStyle.none
        } else {
            return UITableViewCell.EditingStyle.delete
        }
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return AlertButtonTitle.delete
    }
}

extension ListViewController: ListPageTableViewCellDelegate {
    func button(_ button: UIButton, didTapButtonAt data: StoreData) {
        storeData = data
        performSegue(withIdentifier: SegueIdentifier.goToEditVC, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.goToEditVC {
            let editVC = segue.destination as! EditViewController
            guard let storeData = storeData else { return }
            editVC.storeData = storeData
        }
    }
}
