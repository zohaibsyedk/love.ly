//
//  BackgroundView.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/13/26.
//

import SwiftUI

struct BackgroundView: View {
    enum Screen {
        case authen
        case signin
    }
    
    @State private var currentScreen: Screen = .authen
    @Binding var showSignInView: Bool
    @State private var showEmailSignIn = false
    @Binding var curUser: DBUser
    @Binding var curGift: ProductItem
    @Binding var update: Bool
    @Binding var authUser: AuthDataResultModel?
    
    var body: some View {
        ZStack {
            PinkPurpleBackground()
            if currentScreen == .authen {
                NewAuthView(showSignInView: $showSignInView, curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser, currentScreen: $currentScreen)
                    .transition(.move(edge: .leading))
            }
            
            if currentScreen  == .signin {
                
                SignInEmailView(showSignInView: $showSignInView, curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser, currentScreen: $currentScreen)
                    .transition(.move(edge: .trailing))
            }
            
//            switch currentScreen {
//            case .authen:
//                NewAuthView(showSignInView: $showSignInView, curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser, currentScreen: $currentScreen)
//            case .signin:
//                SignInEmailView(showSignInView: $showSignInView, curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser, currentScreen: $currentScreen)
//            }
            
            
        }
        .animation(.easeInOut(duration: 0.2), value: currentScreen)
    }
}
