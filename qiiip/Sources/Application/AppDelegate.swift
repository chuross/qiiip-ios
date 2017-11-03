//
//  AppDelegate.swift
//  qiiip
//
//  Created by chuross on 2017/10/14.
//  Copyright © 2017年 chuross. All rights reserved.
//

import UIKit
import RxSwift
import Keys
import CHQiitaApiClient

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let mainScheduler: SchedulerType = MainScheduler.instance
    let concurrentScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    let configs: QiiipXcodeprojKeys = QiiipXcodeprojKeys()
    var account: Account? {
        get {
            return accountService.account()
        }
    }
    var window: UIWindow?
    var navigationController: UINavigationController?
    private let accountService: AccountService = AccountService()
    
    public static func statusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    public static func navigationBarHeight() -> CGFloat {
        let navigationBarHeight = application().navigationController?.navigationBar.frame.height ?? 0
        return navigationBarHeight + statusBarHeight()
    }
    
    public static func application() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let account = account {
            CHQiitaApiClientAPI.customHeaders["Authorization"] = "Bearer \(account.token)"
        }
    
        navigationController = UINavigationController(rootViewController: HomeScreenViewController())
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5450980392, green: 0.7647058824, blue: 0.2901960784, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let queryItems = URLComponents(string: url.absoluteString)?.queryItems
        if (url.host == "authorize") {
            presentAuthorizeViewController(queryItems: queryItems)
        }
        return true
    }
    
    private func presentAuthorizeViewController(queryItems: [URLQueryItem]?) {
        guard let queryItems = queryItems else { return }
        guard let code = queryItems.first(where: { $0.name == "code" })?.value else { return }
        window?.rootViewController?.present(AuthorizeModalViewController(code: code), animated: true, completion: nil)
    }
    
    func logout() {
        accountService.logout()
    }
    
    func pushScreen(nextViewController viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

}

