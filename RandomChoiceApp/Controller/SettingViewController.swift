//
//  SettingViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/11/23.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UINavigationBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var goBackBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    //UINavigationBarをステータスバーまで広げる
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    enum SettingCategoryList: String, CaseIterable{
        case contactUs = "お問い合わせ"
        case review = "レビューする"
        case appVersion = "アプリバージョン"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        navigationBar.delegate = self
    }
    
    @IBAction func didTapGoBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingCategoryList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingTableViewCell
        
        switch indexPath.row {
        case 0:
            settingCell.settingTitleLabel.text = SettingCategoryList.contactUs.rawValue
            settingCell.indexPathNumber = indexPath.row
            return settingCell
        case 1:
            settingCell.settingTitleLabel.text = SettingCategoryList.review.rawValue
            settingCell.indexPathNumber = indexPath.row
            return settingCell
        case 2:
            let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
            settingCell.settingTitleLabel.text = SettingCategoryList.appVersion.rawValue + version
            settingCell.indexPathNumber = indexPath.row
            settingCell.accessoryType = .none
            return settingCell
        default: break
        }
        return UITableViewCell()
    }
}

extension SettingViewController {
    func setUpTableView() {
        tableView.dataSource = self
        let settingTableViewNib = UINib(nibName: "SettingTableViewCell", bundle: nil)
        tableView.register(settingTableViewNib, forCellReuseIdentifier: "SettingCell")
    }
}
