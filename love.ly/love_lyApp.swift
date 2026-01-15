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
    
    @StateObject var rootModel = RootModel.shared
    @StateObject var giftData = GiftData()
    @State var showClaim: Bool = false
    @State var sendId: String = ""
    @State var loaded = false
    @State var curUser = DBUser()
    @State var curGift = ProductItem()
    @State var update: Bool = true
    @State private var authUser: AuthDataResultModel?
    
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
            RootView(showClaim: $showClaim, sendId: $sendId, curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser)
                .environmentObject(giftData)
                .onOpenURL{ url in
                    let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    if components?.path.starts(with: "/gifts") == true {
                        showClaim = true
                        let parts = url.path.split(separator: "/")
                        sendId = String(parts.last!)
                    }
                    
                }
                
        }
        
    }

    
}
