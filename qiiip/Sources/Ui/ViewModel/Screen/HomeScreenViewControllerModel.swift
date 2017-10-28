//
//  HomeScreenViewControllerModel.swift
//  qiiip
//
//  Created by chuross on 2017/10/28.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import Keys

class HomeScreenViewControllerModel: BaseViewModel {

    private let keys: QiiipXcodeprojKeys = QiiipXcodeprojKeys()
    var authUrl: URL {
        get {
            return URL(string: "https://qiita.com/api/v2/oauth/authorize?client_id=\(keys.qiitaClientId)&scope=read_qiita")!
        }
    }
}
