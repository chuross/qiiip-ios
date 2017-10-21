//
//  UITableView+Xib.swift
//  qiiip
//
//  Created by chuross on 2017/10/21.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func register<T: Registrable>(_ type: T.Type) where T: UITableViewCell {
        switch type {
        case let registrableType as Registrable.Type:
            register(registrableType.nib, forCellReuseIdentifier: registrableType.reuseIdentifier)
        default:
            assertionFailure("\(type) is unknown type")
        }
    }
    
    func dequeueReusableCell<T: Registrable>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with type \(T.self)")
        }
        return cell
    }
}
