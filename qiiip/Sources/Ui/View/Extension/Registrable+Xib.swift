//
//  RegistrableXib.swift
//  qiiip
//
//  Created by chuross on 2017/10/21.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit

extension Registrable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        let nibName = String(describing: self)
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}
