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

    var authUrl: URL {
        get {
            return URL(string: "https://qiita.com/api/v2/oauth/authorize?client_id=\(AppDelegate.application().configs.qiitaClientId)&scope=read_qiita")!
        }
    }
}
