//
//  ItemDetailScreenViewController.swift
//  qiiip
//
//  Created by chuross on 2017/10/26.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import CHQiitaApiClient

class ItemDetailScreenViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var item: Item!
    
    init(item: Item) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
    }
    
     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func loadView() {
        super.loadView()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        
        view.addSubview(webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = item.url else { return }
        webView.load(URLRequest(url: URL(string: url)!))
    }
}
