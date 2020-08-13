//
//  ViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/07/19.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class RandomChoiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListPageTableViewCell", bundle: nil), forCellReuseIdentifier: "ListPagewCell")
        tableView.register(UINib(nibName: "SelectConditionsTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectConditionsCell")
        tableView.register(UINib(nibName: "RandomChoiceButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "RandomChoiceButtonCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let listVC = ListViewController()
        //お店の登録情報がないときにアラートが表示される
//        if listVC.listCellArray.isEmpty {
//            let alert = UIAlertController(title: "登録しているお店がありません。", message: "行ったことのあるお店を登録してみよう！", preferredStyle: .alert)
//            let signupAction = UIAlertAction(title: "登録する", style: .default) { _ in
//                //アラートの登録するボタンを押した後の処理
//                //SignupVCに遷移
//                self.performSegue(withIdentifier: "goToSignupVC", sender: nil)
//            }
//            alert.addAction(signupAction)
//            present(alert, animated: true, completion: nil)
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeInfoCell = tableView.dequeueReusableCell(withIdentifier: "ListPagewCell") as! ListPageTableViewCell
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: "RandomChoiceButtonCell") as! RandomChoiceButtonTableViewCell
        
        switch indexPath.row {
        case 0:
            return storeInfoCell
        case 1:
            return buttonCell
        default:
            break
        }
        return UITableViewCell()
    }
}

