//
//  ItemViewCellDelegate.swift
//  qiiip
//
//  Created by chuross on 2017/10/21.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit
import CHQiitaApiClient
import RxSwift 
import RxCocoa

class ItemViewCellDataSource: NSObject, UITableViewDelegate, UITableViewDataSource, RxTableViewDataSourceType {
    
    typealias Element = [Item]
    
    private var cachedItems: Element = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cachedItems.count
    }
    
    func tableView(_ tableView: UITableView, observedEvent: Event<[Item]>) -> Void {
        if case .next(let items) = observedEvent {
            cachedItems = items
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setItem(item: cachedItems[indexPath.row])
        return cell
    }
}
