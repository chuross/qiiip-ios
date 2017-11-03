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
        
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = menuButton
        
        menuButton.rx.tap
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] _ in
                self?.present(UINavigationController(rootViewController: MenuModalViewController()), animated: true, completion: nil)
            })
            .addDisposableTo(viewModel.disposeBag)

    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [ItemsViewController()]
    }
}
