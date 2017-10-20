//
//  ItemsViewControllerModel.swift
//  qiiip
//
//  Created by chuross on 2017/10/19.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import RxSwift
import CHQiitaApiClient

class ItemsViewControllerModel: PagerViewModel<Item> {
    
    override func source(currentPage: Int32, limit: Int32) -> Single<[Item]> {
        return ItemsAPI.itemsGet(page: currentPage, perPage: limit).asSingle()
    }
    
}
