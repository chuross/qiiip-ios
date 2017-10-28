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

class HomeScreenViewController: TwitterPagerTabStripViewController {
    
    private let viewModel: HomeScreenViewControllerModel = HomeScreenViewControllerModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            containerView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }

        let accountButton = UIBarButtonItem(image: UIImage(named: "Account"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = accountButton
        
        accountButton.rx.tap
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] in /* todo */ })
            .addDisposableTo(viewModel.disposeBag)
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [ItemsViewController()]
    }
}
