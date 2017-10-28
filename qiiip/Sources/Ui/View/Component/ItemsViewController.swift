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
import RxCocoa
import XLPagerTabStrip

class ItemsViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var listView: UITableView!
    private var dataSource: ItemViewCellDataSource? = nil
    private var viewModel: ItemsViewControllerModel? = nil
    private var refreshControl: UIRefreshControl!
    
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
        
        refreshControl = UIRefreshControl()
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { viewModel.fetch() })
            .addDisposableTo(viewModel.disposeBag)

        dataSource = ItemViewCellDataSource()
        guard let dataSource = dataSource else { return }

        listView.refreshControl = refreshControl
        listView.delegate = dataSource
        listView.dataSource = dataSource
        listView.rowHeight = UITableViewAutomaticDimension
        listView.estimatedRowHeight = ItemViewCellDataSource.estimatedRowHeight
        listView.register(ItemViewCell.self)
        
        listView.rx.itemSelected
            .do(onNext: { [weak self] in self?.listView.deselectRow(at: $0, animated: true) })
            .map({ viewModel.listItem(index: $0) })
            .filter({ $0 != nil })
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { item in
                let nextViewController = ItemDetailScreenViewController(item: item!)
                AppDelegate.application().pushScreen(nextViewController: nextViewController)
            })
            .addDisposableTo(viewModel.disposeBag)
        
        viewModel.list.asObservable()
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] items in
                self?.refreshControl.endRefreshing()
                guard let items = items else { return }
                dataSource.items.removeAll()
                dataSource.items.append(contentsOf: items)
                self?.listView.reloadData()
            })
            .addDisposableTo(viewModel.disposeBag)
    }
    
    deinit {
        viewModel?.destroy()
    }

}
