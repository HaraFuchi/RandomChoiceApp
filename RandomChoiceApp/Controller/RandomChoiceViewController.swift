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
//        let resultRestaurantNib = UINib(nibName: "ListPageTableViewCell", bundle: nil)
//        tableView.register(resultRestaurantNib, forCellReuseIdentifier: "ListPageCell")
        let selectConditionsNib = UINib(nibName: "SelectConditionsTableViewCell", bundle: nil)
        tableView.register(selectConditionsNib, forCellReuseIdentifier: "ConditonsCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectConditionsCell = tableView.dequeueReusableCell(withIdentifier: "ConditonsCell", for: indexPath)
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

