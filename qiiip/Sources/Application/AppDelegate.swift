//
//  AppDelegate.swift
//  qiiip
//
//  Created by chuross on 2017/10/14.
//  Copyright © 2017年 chuross. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let mainScheduler: SchedulerType = MainScheduler.instance
    let concurrentScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    var window: UIWindow?
    var navigationController: UINavigationController?
    
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
        
        navigationController = UINavigationController(rootViewController: HomeScreenViewController())
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func pushScreen(nextViewController viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

}

