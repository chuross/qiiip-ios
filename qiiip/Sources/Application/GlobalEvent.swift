//
//  GlobalEvent.swift
//  qiiip
//
//  Created by chuross on 2017/10/30.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import RxSwift

class GlobalEvent {
    
    static let loginChangeEvent: PublishSubject<Account?> = PublishSubject()
}
