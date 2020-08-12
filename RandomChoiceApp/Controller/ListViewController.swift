//
//  ListViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit
import Firebase

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    let crudModel = FirebaseCrudModel()
    
    //outlet
    @IBOutlet weak var signupVCBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var sortItemBottun: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //action
    @IBAction func touchedSearchButton(_ sender: UIButton) {
    }
    
    @IBAction func touchedSortButton(_ sender: UIButton) {
    }
    
    @IBAction func touchedScreenRecognizer(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        let listPageNib = UINib(nibName: "ListPageTableViewCell", bundle: nil)
        tableView.register(listPageNib, forCellReuseIdentifier: "ListPageCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        crudModel.fetchStoreData(tableView: tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crudModel.listCellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPageCell", for: indexPath) as! ListPageTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //後ほど、追加する機能 ↓
        //セルをタップしたら詳細ページに遷移させる
    }
    
    //セルの編集許可(スワイプを可能にする)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //スワイプしたセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        //styleをアクションシートに設定
//        let showAlert = UIAlertController(title: "お店一覧から削除しますか？", message: "", preferredStyle: .alert)
//        //選択肢を生成
//        let deleteAction = UIAlertAction(title: "削除", style: .destructive, handler: { _ -> Void in
//            //処理: 一覧から削除
//            if editingStyle == UITableViewCell.EditingStyle.delete {
//                self.listCellArray.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
//            }
//        })
//        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { _ -> Void in
//        })
//        showAlert.addAction(cancelAction)
//        showAlert.addAction(deleteAction)
//        //UIAlertControllerの起動
//        present(showAlert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
