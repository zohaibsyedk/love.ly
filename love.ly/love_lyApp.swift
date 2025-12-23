//
//  love_lyApp.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/17/25.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct love_lyApp: App {
    
    class AppDelegate: NSObject, UIApplicationDelegate {
      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
      }
    }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }

    
}
