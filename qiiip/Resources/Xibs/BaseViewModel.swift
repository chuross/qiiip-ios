//
//  BaseViewModel.swift
//  qiiip
//
//  Created by chuross on 2017/10/19.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import RxSwift

open class BaseViewModel : ViewModel {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    func create() {
    }
    
    func destroy() {
    }
}
