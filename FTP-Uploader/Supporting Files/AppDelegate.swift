//
//  AppDelegate.swift
//  FTP-Uploader
//
//  Created by Golos on 3/3/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: FlowCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        coordinator = FlowCoordinator(window: window)

        return true
    }
}
