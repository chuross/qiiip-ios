//
//  ViewModel.swift
//  qiiip
//
//  Created by chuross on 2017/10/19.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import RxSwift

 protocol ViewModel {
    
    var disposeBag: DisposeBag { get }
    
    func create()
    
    func destroy()
}
