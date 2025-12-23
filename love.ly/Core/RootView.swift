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
    
    var body: some View {
        
        FloatingTabView(selection: $activeTab) { tab, tabBarHeight in
            switch tab {
            case .home: ProfileView(showSignInView: $showSignInView)
            case .shop: ShopView()
            case .about:Text("About")
            case .settings: SettingsView(showSignInView: $showSignInView)
            }
            
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil ? true : false
            
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}


#Preview {
    RootView()
}
