//
//  Registrable.swift
//  qiiip
//
//  Created by chuross on 2017/10/21.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit

protocol Registrable: class {
    
    static var nib: UINib { get }
    static var reuseIdentifier: String { get }
}
