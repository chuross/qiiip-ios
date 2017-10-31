//
//  UINavigationController+StatusBar.swift
//  qiiip
//
//  Created by chuross on 2017/11/01.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? UIStatusBarStyle.lightContent
    }

}
