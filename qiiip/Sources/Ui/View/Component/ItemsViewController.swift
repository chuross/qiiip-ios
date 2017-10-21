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

class ItemsViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var listView: UITableView!
    private var delegate: ItemViewCellDelegate? = nil
    private var viewModel: ItemsViewControllerModel? = nil
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "すべての投稿")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ItemsViewControllerModel()
        viewModel?.fetch()
        
        delegate = ItemViewCellDelegate()
            
        listView.register(ItemViewCell.self)
    }
}
