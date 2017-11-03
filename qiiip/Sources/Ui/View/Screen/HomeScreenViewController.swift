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
import SDWebImage
import APAvatarImageView

class HomeScreenViewController: TwitterPagerTabStripViewController {
    
    private let viewModel: HomeScreenViewControllerModel = HomeScreenViewControllerModel()
    private let accountService: AccountService = AccountService()
    private var tabViewControllers: [UIViewController] = []
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            containerView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = menuButton
        
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Search"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = searchButton
        
        menuButton.rx.tap
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] _ in
                self?.present(UINavigationController(rootViewController: MenuModalViewController()), animated: true, completion: nil)
            })
            .addDisposableTo(viewModel.disposeBag)
        
        searchButton.rx.tap
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { _ in  })
            .addDisposableTo(viewModel.disposeBag)
        
        viewModel.loginChangeEvent
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] account in
                self?.setupTabViewControllers()
                self?.reloadPagerTabStripView()
            })
            .addDisposableTo(viewModel.disposeBag)
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        setupTabViewControllers()
        return tabViewControllers
    }
    
    private func setupTabViewControllers() {
        if let account = AppDelegate.application().account {
            tabViewControllers = [ItemsViewController(), StockItemsViewController(userId: account.user.id)]
        } else {
            tabViewControllers = [ItemsViewController()]
        }
    }
}
