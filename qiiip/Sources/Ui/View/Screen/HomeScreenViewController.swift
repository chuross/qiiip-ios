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

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            containerView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }

        if let account = accountService.account() {
            setupAccountButton(account)
        } else {
            setupGuestButton()
        }
        
        viewModel.loginChangeEvent
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] account in
                if (account != nil) {
                    self?.setupAccountButton(account!)
                } else {
                    self?.setupGuestButton()
                }
            })
            .addDisposableTo(viewModel.disposeBag)
    }
    
    private func setupGuestButton() {
        let accountButton = UIBarButtonItem(image: UIImage(named: "Account"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = accountButton
    
        accountButton.rx.tap
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] _ in
                guard let viewModel = self?.viewModel else { return }
                UIApplication.shared.open(viewModel.authUrl, options: [:], completionHandler: nil)
            })
            .addDisposableTo(viewModel.disposeBag)
    }
    
    private func setupAccountButton(_ account: Account) {
        let imageView = APAvatarImageView(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
        if let thumbnail = account.user.profileImageUrl {
            imageView.sd_setImage(with: URL(string: thumbnail)!, completed: nil)
        }
        let accountButton = UIBarButtonItem(customView: imageView)
        navigationItem.leftBarButtonItem = accountButton
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [ItemsViewController()]
    }
}
