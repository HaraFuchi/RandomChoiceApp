//
//  UIViewController+UINavigationBar.swift
//  RandomChoiceApp
//
//  Created by Kazuma Fuchi on 2020/12/21.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

extension UIViewController: UINavigationBarDelegate {
    //UINavigationBarをステータスバーまで広げる
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
