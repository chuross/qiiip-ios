//
//  HomeScreenViewControllerModel.swift
//  qiiip
//
//  Created by chuross on 2017/10/28.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import Keys
import RxSwift

class HomeScreenViewControllerModel: BaseViewModel {
    
    let loginChangeEvent: Observable<Account?> = GlobalEvent.loginChangeEvent
}
