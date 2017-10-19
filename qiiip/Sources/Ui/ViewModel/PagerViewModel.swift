//
//  PagerViewModel.swift
//  qiiip
//
//  Created by chuross on 2017/10/19.
//  Copyright © 2017年 chuross. All rights reserved.
//

import RxSwift

open class PagerViewModel<I> : BaseViewModel {
    
    let isLoading: Variable<Bool> = Variable(false)
    let list: Variable<[I]?> = Variable(nil)
    let error: Variable<Error?> = Variable(nil)
    let currentPage: Variable<Int32> = Variable(1)
    private let limit: Int32 = 20
    private let defaultPage: Int32 = 1
    
    func source(currentPage: Int32, limit: Int32) -> Single<[I]> {
        return Single.error(NSError(domain: "not inplemented", code: -1))
    }
    
    func fetch() {
        self.isLoading.value = true
        
        getPagerSource(page: currentPage.value, limit: limit)
            .do(onNext: { _ in self.currentPage.value = self.defaultPage })
            .subscribe(onSuccess: { list in
                self.list.value = list
                self.error.value = nil
            }, onError: { error in
                self.error.value = error
            })
            .addDisposableTo(disposeBag)
    }
    
    func fetchNext() {
        self.isLoading.value = true
        
        getPagerSource(page: currentPage.value, limit: limit)
            .subscribe(onSuccess: { list in
                self.list.value?.append(contentsOf: list)
            })
            .addDisposableTo(disposeBag)
        
    }
    
    private func getPagerSource(page: Int32, limit: Int32) -> Single<[I]> {
        return source(currentPage: page, limit: limit)
            .subscribeOn(AppDelegate.application().concurrentScheduler)
            .observeOn(CurrentThreadScheduler.instance)
            .do(onCompleted: { () in self.isLoading.value = false })
            .do(onNext: { _ in self.currentPage.value += 1 })
    }
    
}
