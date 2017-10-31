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

class MenuViewModalController: FormViewController {

    private let viewModel: SimpleViewModel = SimpleViewModel()
    private let accountService: AccountService = AccountService()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "メインメニュー"
        let closeButton =  UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
        navigationItem.rightBarButtonItem = closeButton
        
        if let account = accountService.account() {
            setupAccountInfo(account: account)
        } else {
            
        }
        
        closeButton.rx.tap
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] in self?.dismiss(animated: true, completion: nil) })
            .addDisposableTo(viewModel.disposeBag)
    }
    
    private func setupAccountInfo(account: Account) {
        form +++ Section("アカウント")
            <<< LabelRow() { $0.title = account.user.id }
            <<< ButtonRow() { $0.title = "ログアウト" }
                .cellSetup({ cell, row in cell.tintColor = .red })
        +++ Section("アプリについて")
            <<< LabelRow() { $0.title = "バージョン \(AppDelegate.application().version)" }
    }

}
