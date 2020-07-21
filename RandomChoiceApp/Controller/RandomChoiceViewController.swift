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
    
    enum Cell: Int, CaseIterable {
        case firstCustomViewCell
        case secondCustomViewCell
        case thirdCustomViewCell

        var cellIdentifier: String {
            switch self {
            case .firstCustomViewCell: return "ListPageTableViewCell"
            case .secondCustomViewCell: return "SelectConditionsTableViewCell"
            case .thirdCustomViewCell: return "RandomChoiceButtonTableViewCell"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListPageTableViewCell", bundle: nil), forCellReuseIdentifier: "ListPageTableViewCell")
        tableView.register(UINib(nibName: "SelectConditionsTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectConditionsTableViewCell")
        tableView.register(UINib(nibName: "RandomChoiceButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "RandomChoiceButtonTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cell.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = Cell(rawValue: indexPath.row)!
        switch cellType {
        case .firstCustomViewCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier) as! ListPageTableViewCell
            return cell
        case .secondCustomViewCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier) as! SelectConditionsTableViewCell
            return cell
        case .thirdCustomViewCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier) as! RandomChoiceButtonTableViewCell
            return cell
        }
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 250
   }
}

