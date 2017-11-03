//
//  StockItemViewControllerModel.swift
//  qiiip
//
//  Created by chuross on 2017/11/03.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import RxSwift
import CHQiitaApiClient

class StockItemsViewControllerModel: PagerViewModel<Item> {
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    override func source(currentPage: Int32, limit: Int32) -> Single<[Item]> {
        return ItemsAPI.usersUserIdStocksGet(userId: userId, page: currentPage, perPage: limit).asSingle()
    }
}
