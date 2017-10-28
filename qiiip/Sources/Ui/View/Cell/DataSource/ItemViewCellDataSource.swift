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

class ItemViewCellDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    public static let estimatedRowHeight: CGFloat = 120
    
    var items: [Item] = []
    var loadMoreListener: (() -> Void)? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setItem(item: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row != items.count - 1) {
            return
        }
        
        guard let loadMore = loadMoreListener else { return }
        loadMore()
    }
}
