//
//  ItemViewCell.swift
//  qiiip
//
//  Created by chuross on 2017/10/20.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit
import CHQiitaApiClient

class ItemViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var userIconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    func setItem(item: Item) {
        nameLabel.text = item.user?.name
        titleLabel.text = item.title
        tagLabel.text = item.tags?.reduce("", { current, tag in "\(current), \(tag.name)" })
    }
}
