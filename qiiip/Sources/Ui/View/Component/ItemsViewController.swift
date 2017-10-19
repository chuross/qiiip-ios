//
//  ItemsViewController.swift
//  qiiip
//
//  Created by chuross on 2017/10/19.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class ItemsViewController : UIViewController, IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "すべての投稿")
    }
}
