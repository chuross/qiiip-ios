//
//  HomeScreenViewController.swift
//  qiiip
//
//  Created by chuross on 2017/10/14.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class HomeScreenViewController : TwitterPagerTabStripViewController {
    
    override func viewDidLoad() {
        self.settings.style.titleColor = self.view.tintColor
        self.settings.style.dotColor = self.view.tintColor
        self.settings.style.selectedDotColor = self.view.tintColor
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [ItemsViewController()]
    }
}
