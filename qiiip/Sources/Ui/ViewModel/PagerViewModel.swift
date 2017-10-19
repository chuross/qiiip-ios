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
    let currentOffset: Variable<Int> = Variable(0)
    private let limit: Int = 20
    
    func source(currentOffset: Int, limit: Int) -> Single<[I]> {
        return Single.error(NSError(domain: "not inplemented", code: -1))
    }
    
    func fetch() {
        isLoading.value = true
        
        getPagerSource(offset: currentOffset.value, limit: limit)
            .subscribe(onSuccess: { list in
                self.list.value = list
                self.error.value = nil
            }, onError: { error in
                self.error.value = error
            })
            .addDisposableTo(disposeBag)
    }
    
    func fetchNext() {
        isLoading.value = true
        
        getPagerSource(offset: currentOffset.value, limit: limit)
            .subscribe(onSuccess: { list in
                self.list.value?.append(contentsOf: list)
            })
            .addDisposableTo(disposeBag)
        
    }
    
    private func getPagerSource(offset: Int, limit: Int) -> Single<[I]> {
        return source(currentOffset: offset, limit: limit)
            .subscribeOn(AppDelegate.application().concurrentScheduler)
            .observeOn(CurrentThreadScheduler.instance)
            .do(onCompleted: { () in self.isLoading.value = false })
    }
    
}
