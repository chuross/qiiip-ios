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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    private func initialize() {
        viewModel = ItemsViewControllerModel()
        viewModel?.fetch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }
        
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
                dataSource.items.removeAll()
                dataSource.items.append(contentsOf: items)
                self.listView.reloadData()
            })
            .addDisposableTo(viewModel.disposeBag)
    }
    
    deinit {
        viewModel?.destroy()
    }

}
