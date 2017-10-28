//
//  Account.swift
//  qiiip
//
//  Created by chuross on 2017/10/29.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import CHQiitaApiClient

struct Account {
    
    let user: User
    let token: String
    
    init(user: User, token: String) {
        self.user = user
        self.token = token
    }
}
