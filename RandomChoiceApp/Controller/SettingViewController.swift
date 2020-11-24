//
//  SettingViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/11/23.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UINavigationBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var settingCell = SettingTableViewCell()
    
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
        settingCell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingTableViewCell
        
        switch indexPath.row {
        case 0:
            settingCell.settingTitleLabel.text = SettingCategoryList.contactUs.rawValue
            settingCell.subTitleLabel.text = ""
            settingCell.indexPathNumber = indexPath.row
            return settingCell
        case 1:
            settingCell.settingTitleLabel.text = SettingCategoryList.review.rawValue
            settingCell.subTitleLabel.text = ""
            settingCell.indexPathNumber = indexPath.row
            return settingCell
        case 2:
            settingCell.settingTitleLabel.text = SettingCategoryList.appVersion.rawValue
            settingCell.accessoryType = .none
            settingCell.selectionStyle = .none
            let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
            settingCell.subTitleLabel.text = version
            settingCell.indexPathNumber = indexPath.row
            return settingCell
        default: break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            settingCell.indexPathNumber = indexPath.row
        case 1:
            //外部ブラウザでURLを開く
            let url = NSURL(string: "https://apps.apple.com/jp/app/%E3%81%95%E3%81%84%E3%81%93%E3%82%8Dde%E3%81%94%E3%81%AF%E3%82%93/id1528912786?mt=8&action=write-review")
            if UIApplication.shared.canOpenURL(url! as URL){
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            }
            settingCell.indexPathNumber = indexPath.row
        case 2:
            settingCell.indexPathNumber = indexPath.row
        default: break
        }
    }
}

extension SettingViewController {
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let settingTableViewNib = UINib(nibName: "SettingTableViewCell", bundle: nil)
        tableView.register(settingTableViewNib, forCellReuseIdentifier: "SettingCell")
    }
}
