//
//  RootView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/18/25.
//

import SwiftUI

enum AppTab: String, CaseIterable, FloatingTabProtocol {
    case home = "Home"
    case shop = "Shop"
    case about = "About"
    case settings = "Settings"
    
    var symbolImage: String {
        switch self {
        case .home: return "house"
        case .shop: return "bag"
        case .about: return "info.circle.fill"
        case .settings: return "gear"
        }
        
    }
}

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    @State private var activeTab: AppTab = .home
    @Binding var showClaim: Bool
    @Binding var sendId: String
    @Binding var curUser: DBUser
    @Binding var curGift: ProductItem
    @Binding var update: Bool
    @Binding var authUser: AuthDataResultModel?
    
    var body: some View {
        
        FloatingTabView(selection: $activeTab) { tab, tabBarHeight in
            switch tab {
            case .home: ProfileView(showSignInView: $showSignInView, curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser, activeTab: $activeTab)
            case .shop: ShopView(showSignInView: $showSignInView, curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser, activeTab: $activeTab)
            case .about:Text("About")
            case .settings: SettingsView(showSignInView: $showSignInView, curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser, activeTab: $activeTab)
            }
            
        }
        .task {
            
        }
        .onAppear {
            authUser = AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil ? true : false
            
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                BackgroundView(showSignInView: $showSignInView, curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser)
            }
        }
        .fullScreenCover(isPresented: $showClaim) {
            NavigationStack {
                ProductClaimView(sendId: $sendId, showClaim: $showClaim, curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser)
            }
        }
    }
}


