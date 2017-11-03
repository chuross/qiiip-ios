//
//  StockItemsViewController.swift
//  qiiip
//
//  Created by chuross on 2017/11/03.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class StockItemsViewController: UIViewController, IndicatorInfoProvider {
    
    private var userId: String!
    private var viewModel: StockItemsViewControllerModel!
    private var refreshControl: UIRefreshControl!
    private var dataSource: ItemViewCellDataSource!
    @IBOutlet weak var listView: UITableView!
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "ストックした投稿")
    }
    
    init(userId: String) {
        super.init(nibName: nil, bundle: nil)
        self.userId = userId
        viewModel = StockItemsViewControllerModel(userId: userId)
        viewModel.fetch()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] _ in self?.viewModel.fetch() })
            .addDisposableTo(viewModel.disposeBag)
        
        dataSource = ItemViewCellDataSource()
        dataSource?.loadMoreListener = { self.viewModel.fetchNext() }
        
        listView.refreshControl = refreshControl
        listView.delegate = dataSource
        listView.dataSource = dataSource
        listView.rowHeight = UITableViewAutomaticDimension
        listView.estimatedRowHeight = ItemViewCellDataSource.estimatedRowHeight
        listView.register(ItemViewCell.self)
        
        listView.rx.itemSelected
            .do(onNext: { [weak self] in self?.listView.deselectRow(at: $0, animated: true) })
            .map({ [weak self] index in self?.viewModel.listItem(index: index) })
            .filter({ $0 != nil })
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { item in
                let nextViewController = ItemDetailScreenViewController(item: item!)
                AppDelegate.application().pushScreen(nextViewController: nextViewController)
            })
            .addDisposableTo(viewModel.disposeBag)
        
        viewModel.isLoading.asObservable()
            .filter({ !$0 })
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] _ in
                self?.refreshControl.endRefreshing()
            })
            .addDisposableTo(viewModel.disposeBag)
        
        viewModel.list.asObservable()
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] items in
                guard let items = items else { return }
                self?.dataSource.items.removeAll()
                self?.dataSource.items.append(contentsOf: items)
                self?.listView.reloadData()
            })
            .addDisposableTo(viewModel.disposeBag)
    }

}
