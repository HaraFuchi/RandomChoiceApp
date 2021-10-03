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

final class SettingViewController: UIViewController {

    private let appVersion = Bundle.main.object(forInfoDictionaryKey: BundleIdentifier.appVersion) as? String

    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var backBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var tableViewHeight: NSLayoutConstraint!

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            let nib = UINib(nibName: SettingTableViewCell.className, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: SettingTableViewCell.className)
            tableView.isScrollEnabled = false
        }
    }

    private enum SettingCategoryList: Int, CaseIterable {
        case contactUs, review, appVersion

        var title: String {
            switch self {
            case .contactUs: return SettingTitle.contact
            case .review: return SettingTitle.review
            case .appVersion: return SettingTitle.appVersion
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableViewHeight.constant = .init(tableView.contentSize.height)
    }

    @IBAction private func didTapBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

/**********************************************************************/
// MARK: - Protocol
/**********************************************************************/
extension SettingViewController: UINavigationBarDelegate {
    // UINavigationBarをステータスバーまで広げる
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        .topAttached
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingCategoryList.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.className, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }

        cell.isSubTitleLabelHidden = true

        guard let cellType = SettingCategoryList(rawValue: indexPath.row) else { return UITableViewCell() }

        switch cellType {
        case .contactUs:
            cell.titleText = SettingCategoryList.contactUs.title
            return cell
        case .review:
            cell.titleText = SettingCategoryList.review.title
            return cell
        case .appVersion:
            cell.titleText = SettingCategoryList.appVersion.title
            cell.accessoryType = .none
            cell.selectionStyle = .none
            cell.isSubTitleLabelHidden = false
            cell.subTitleText = appVersion
            return cell
        }
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let cellType = SettingCategoryList(rawValue: indexPath.row) else { return }

        switch cellType {
        case .contactUs:
            composeMail()
        case .review:
            // 外部ブラウザでURLを開く
            guard let url = URL(string: Url.appStoreReview),
                  UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url)
        case .appVersion: break
        }
    }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    /// メール送信画面を開く
    private func composeMail() {
        guard MFMailComposeViewController.canSendMail() else {
            // 有効なメールアドレスがないため、メール送信画面が開けない場合
            showAlertNoEmailAddress()
            return
        }
        // メール作成
        let composer = MFMailComposeViewController()
        let iOSVersion = UIDevice.current.systemVersion
        let user = Auth.auth().currentUser!.uid
        composer.mailComposeDelegate = self
        // 宛先 (TO・CC・BCC)
        composer.setToRecipients([EmailInfo.address])
        // 件名
        composer.setSubject(EmailInfo.subject)
        // 本文
        guard let appVersion = appVersion else { return }
        composer.setMessageBody(EmailInfo.messageBody1 + appVersion + EmailInfo.messageBody2 + iOSVersion + EmailInfo.messageBody3 + user, isHTML: false)
        present(composer, animated: true, completion: nil)
    }

    // メール送信結果をハンドリング
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            print(error)
        }
        switch result {
        case .cancelled:
            print(EmailStatus.cancelled)
        case .saved:
            print(EmailStatus.saved)
        case .sent:
            print(EmailStatus.sent)
        case .failed:
            print(EmailStatus.failed)
        default: break
        }
        // メール画面を閉じる
        controller.dismiss(animated: true, completion: nil)
    }

    private func showAlertNoEmailAddress() {
        let alert = UIAlertController(title: AlertTitle.email, message: AlertMessage.email, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: AlertButtonTitle.ok, style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
