//
//  SettingViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/11/23.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class SettingViewController: UIViewController, UINavigationBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private var settingCell = SettingTableViewCell()
    private var appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var goBackBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var tableView: UITableView!
    
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
    
    @IBAction private func didTapGoBackButton(_ sender: UIBarButtonItem) {
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
            settingCell.subTitleLabel.text = appVersion
            settingCell.indexPathNumber = indexPath.row
            return settingCell
        default: break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            composeMail()
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
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let settingTableViewNib = UINib(nibName: "SettingTableViewCell", bundle: nil)
        tableView.register(settingTableViewNib, forCellReuseIdentifier: "SettingCell")
    }
}

// MARK: MFMailComposeViewController
extension SettingViewController: MFMailComposeViewControllerDelegate {
    /// メール送信画面を開く
    private func composeMail() {
        guard MFMailComposeViewController.canSendMail() else {
            // 有効なメールアドレスがないため、メール送信画面が開けない場合
            showAlertNoEmailAddress()
            print("有効なメールアドレスが存在しません")
            return
        }
        // メール作成
        let composer = MFMailComposeViewController()
        let iOSVersion = UIDevice.current.systemVersion
        let user = Auth.auth().currentUser!.uid
        composer.mailComposeDelegate = self
        // 宛先 (TO・CC・BCC)
        composer.setToRecipients(["harafuchi0324@gmail.com"])
        // 件名
        composer.setSubject("【さいころdeごはん】お問い合わせ")
        // 本文
        composer.setMessageBody("下記にお問い合わせ内容をお書きください。\n\n\n\n\nAppVersion: \(appVersion)\nPlatformVersion: \(iOSVersion)\nUserID: \(user)",isHTML: false)
        present(composer, animated: true, completion: nil)
    }
    
    // メール送信結果をハンドリング
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            print(error)
        } else {
            switch result {
            case .cancelled:
                print("メールの作成がキャンセルされました")
                break
            case .saved:
                print("メールが下書きに保存されました")
                break
            case .sent:
                print("メールの送信に成功しました")
                break
            case .failed:
                print("メールの送信に失敗しました")
                break
            default:
                break
            }
        }
        // メール画面を閉じる
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func showAlertNoEmailAddress() {
        let alert = UIAlertController(title: "メールが開けません", message: "設定からメールアドレスを追加してください。", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
