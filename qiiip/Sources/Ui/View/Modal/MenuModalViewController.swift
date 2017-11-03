//
//  MenuViewController.swift
//  qiiip
//
//  Created by chuross on 2017/11/01.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit
import Eureka

class MenuModalViewController: FormViewController {

    private let viewModel: MenuModalViewControllerModel = MenuModalViewControllerModel()
    private let accountService: AccountService = AccountService()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "メインメニュー"
        let closeButton =  UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
        navigationItem.rightBarButtonItem = closeButton
        
        if let account = accountService.account() {
            setupAccountInfo(account: account)
        } else {
            setupGuestInfo()
        }
        
        closeButton.rx.tap
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] in self?.dismiss(animated: true, completion: nil) })
            .addDisposableTo(viewModel.disposeBag)
        
        GlobalEvent.loginChangeEvent
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] account in
                if let account = account {
                    self?.setupAccountInfo(account: account)
                } else {
                    self?.setupGuestInfo()
                }
            })
            .addDisposableTo(viewModel.disposeBag)
    }
    
    private func setupAccountInfo(account: Account) {
        form.removeAll()
        form +++ Section("アカウント")
            <<< LabelRow() { $0.title = account.user.id }
            <<< ButtonRow() { $0.title = "ログアウト" }
                .cellSetup({ cell, row in cell.tintColor = .red })
                .onCellSelection({ _, _ in
                    AppDelegate.application().logout()
                    GlobalEvent.loginChangeEvent.onNext(nil)
                })
        setupCommonSection()
    }
    
    private func setupGuestInfo() {
        form.removeAll()
        form +++ Section("アカウント")
            <<< ButtonRow() { $0.title = "ログイン" }
                .onCellSelection({ _, _ in
                    UIApplication.shared.open(self.viewModel.authUrl, options: [:], completionHandler: nil)
                })
        setupCommonSection()
    }
    
    private func setupCommonSection() {
        form +++ Section("アプリについて")
            <<< LabelRow() { $0.title = "バージョン \(AppDelegate.application().version)" }
    }

}
