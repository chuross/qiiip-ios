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

class ItemDetailScreenViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
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
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        view.addSubview(webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = item.url else { return }
        webView.load(URLRequest(url: URL(string: url)!))
    }
}
