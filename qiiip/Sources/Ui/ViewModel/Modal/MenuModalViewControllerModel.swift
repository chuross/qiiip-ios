//
//  MenuModalViewControllerModel.swift
//  qiiip
//
//  Created by chuross on 2017/11/03.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation

class MenuModalViewControllerModel: BaseViewModel {
    
    var authUrl: URL {
        get {
            let clientId = AppDelegate.application().configs.qiitaClientId
            return URL(string: "http://qiita.com/api/v2/oauth/authorize?client_id=\(clientId)&scope=read_qiita")!
        }
    }
}
