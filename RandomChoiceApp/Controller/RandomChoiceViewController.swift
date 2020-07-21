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
    
    //    enum Cell: Int, CaseIterable {
    //        case firstCustomViewCell
    //        case secondCustomViewCell
    //        case thirdCustomViewCell
    //
    //        var cellIdentifier: String {
    //            switch self {
    //            case .firstCustomViewCell: return "ListPageTableViewCell"
    //            case .secondCustomViewCell: return "SelectConditionsTableViewCell"
    //            case .thirdCustomViewCell: return "RandomChoiceButtonTableViewCell"
    //            }
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListPageTableViewCell", bundle: nil), forCellReuseIdentifier: "ListPagewCell")
        tableView.register(UINib(nibName: "SelectConditionsTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectConditionsCell")
        tableView.register(UINib(nibName: "RandomChoiceButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "RandomChoiceButtonCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListPagewCell") as! ListPageTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectConditionsCell") as! SelectConditionsTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RandomChoiceButtonCell") as! RandomChoiceButtonTableViewCell
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}

