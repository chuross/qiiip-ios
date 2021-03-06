//
//  ItemViewCell.swift
//  qiiip
//
//  Created by chuross on 2017/10/20.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import CHQiitaApiClient
import APAvatarImageView

class ItemViewCell: UITableViewCell, Registrable {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var userIconImage: APAvatarImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    private let dateFormatter: DateFormatter = DateFormatter()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        dateFormatter.dateFormat = "がyyyy/MM/dd HH:mm:ssに投稿"
    }
    
    func setItem(item: Item) {
        userIconImage.borderWidth = 0
        userIconImage.sd_setImage(with: URL(string: item.user?.profileImageUrl ?? ""))
        nameLabel.text = item.user?.id
        createdAtLabel.text = dateFormatter.string(from: item.createdAt)
        titleLabel.text = item.title
        tagLabel.text = item.tags?.map({ $0.name ?? "" }).joined(separator: ", ") ?? ""
    }
}
