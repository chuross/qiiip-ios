//
//  AuthorizeViewControllerModel.swift
//  qiiip
//
//  Created by chuross on 2017/10/29.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import RxSwift

class AuthorizeModalViewControllerModel: BaseViewModel {
    
    let loginSuccessEvent: Observable<Account> = GlobalEvent.loginChangeEvent.filter({ $0 != nil }).map({ $0! })
    let loginFailedEvent: PublishSubject<Void> = PublishSubject()
    private let code: String
    private let accountService: AccountService = AccountService()
    
    init(code: String) {
        self.code = code
        super.init()
    }
    
    func login() {
        accountService.login(code: code)
            .subscribeOn(AppDelegate.application().backgroundScheduler)
            .observeOn(CurrentThreadScheduler.instance)
            .subscribe(onNext: { account in
                GlobalEvent.loginChangeEvent.onNext(account)
            }, onError: { [weak self] _ in
                self?.loginFailedEvent.onNext()
            })
            .addDisposableTo(disposeBag)
    }
}
