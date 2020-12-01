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
    private var appVersion = Bundle.main.object(forInfoDictionaryKey: BundleIdentifierLiteral.appVersion) as! String
    
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
        settingCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLiteral.settingCell, for: indexPath) as! SettingTableViewCell
        settingCell.subTitleLabel.isHidden = true
        
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
            settingCell.settingTitleLabel.text = SettingCategoryList.appVersion.rawValue
            settingCell.accessoryType = .none
            settingCell.selectionStyle = .none
            settingCell.subTitleLabel.isHidden = false
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
            let url = NSURL(string: UrlLiteral.appStoreReviewUrl)
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
        let settingTableViewNib = UINib(nibName: NibNameLiteral.settingTableViewCell, bundle: nil)
        tableView.register(settingTableViewNib, forCellReuseIdentifier: CellIdentifierLiteral.settingCell)
    }
}

// MARK: MFMailComposeViewController
extension SettingViewController: MFMailComposeViewControllerDelegate {
    /// メール送信画面を開く
    private func composeMail() {
        guard MFMailComposeViewController.canSendMail() else {
            // 有効なメールアドレスがないため、メール送信画面が開けない場合
            showAlertNoEmailAddress()
            print(DebugEmailLiteral.noEmailAddress)
            return
        }
        // メール作成
        let composer = MFMailComposeViewController()
        let iOSVersion = UIDevice.current.systemVersion
        let user = Auth.auth().currentUser!.uid
        composer.mailComposeDelegate = self
        // 宛先 (TO・CC・BCC)
        composer.setToRecipients([EmailLiteral.emailAddress])
        // 件名
        composer.setSubject(EmailLiteral.emailSubject)
        // 本文
        composer.setMessageBody(EmailLiteral.messageBody_1 + appVersion + EmailLiteral.messageBody_2 + iOSVersion + EmailLiteral.messageBody_3 + user, isHTML: false)
        present(composer, animated: true, completion: nil)
    }
    
    // メール送信結果をハンドリング
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            print(error)
        } else {
            switch result {
            case .cancelled:
                print(DebugEmailLiteral.cancelled)
                break
            case .saved:
                print(DebugEmailLiteral.saved)
                break
            case .sent:
                print(DebugEmailLiteral.sent)
                break
            case .failed:
                print(DebugEmailLiteral.failed)
                break
            default:
                break
            }
        }
        // メール画面を閉じる
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func showAlertNoEmailAddress() {
        let alert = UIAlertController(title: AlertTitleLiteral.email, message: AlertMessageLiteral.email, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: AlertButtonLiteral.OK, style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
