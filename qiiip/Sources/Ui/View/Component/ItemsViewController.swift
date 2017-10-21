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
import RxSwift
import RxCocoa

class ItemsViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var listView: UITableView!
    private var delegate: ItemViewCellDataSource? = nil
    private var viewModel: ItemsViewControllerModel? = nil
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "すべての投稿")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ItemsViewControllerModel()
        
        guard let viewModel = viewModel else { return }
        viewModel.fetch()
        
        delegate = ItemViewCellDataSource()
            
        listView.register(ItemViewCell.self)
        
    }
}
