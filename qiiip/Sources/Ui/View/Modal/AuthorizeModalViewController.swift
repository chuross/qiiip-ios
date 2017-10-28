//
//  AuthorizeViewController.swift
//  qiiip
//
//  Created by chuross on 2017/10/29.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit

class AuthorizeModalViewController: UIViewController {
    
    private var viewModel: AuthorizeModalViewControllerModel!
    
    public init(code: String) {
        viewModel = AuthorizeModalViewControllerModel(code: code)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.login()
        
        viewModel.loginSuccessEvent
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] _ in self?.dismiss(animated: true, completion: nil) })
            .addDisposableTo(viewModel.disposeBag)
        
        viewModel.loginFailedEvent
            .subscribeOn(AppDelegate.application().mainScheduler)
            .observeOn(AppDelegate.application().mainScheduler)
            .subscribe(onNext: { [weak self] _ in self?.dismiss(animated: true, completion: nil) })
            .addDisposableTo(viewModel.disposeBag)
    }
}
