//
//  ItemsViewController.swift
//  qiiip
//
//  Created by chuross on 2017/10/19.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import XLPagerTabStrip

class ItemsViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var listView: UITableView!
    private var dataSource: ItemViewCellDataSource? = nil
    private var viewModel: ItemsViewControllerModel? = nil
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "すべての投稿")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ItemsViewControllerModel()
        
        guard let viewModel = viewModel else { return }
        viewModel.fetch()
        
        dataSource = ItemViewCellDataSource()
        guard let dataSource = dataSource else { return }
        
        listView.delegate = dataSource
        listView.dataSource = dataSource        
        listView.rowHeight = UITableViewAutomaticDimension
        listView.register(ItemViewCell.self)
        
        viewModel.list.asObservable()
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { items in
                guard let items = items else { return }
                dataSource.items.append(contentsOf: items)
                self.listView.reloadData()
            })
            .addDisposableTo(viewModel.disposeBag)
        
    }
}
