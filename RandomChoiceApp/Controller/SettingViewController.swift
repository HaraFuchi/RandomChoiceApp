//
//  SettingViewController.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/11/23.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UINavigationBarDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var goBackBarButtonItem: UIBarButtonItem!
    
    //UINavigationBarをステータスバーまで広げる
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
    }
    
    @IBAction func didTapGoBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
