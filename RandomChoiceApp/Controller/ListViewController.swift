//
//  ListViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //UI作成のため、一旦セルの数は20に設定しています
    //本来は、新規登録画面で保存された内容・数のセルを表示
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPageCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //後ほど、追加する機能 ↓
        //セルをタップしたら詳細ページに遷移させる
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
