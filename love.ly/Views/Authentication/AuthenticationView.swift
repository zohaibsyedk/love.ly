//
//  AuthenticationView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/18/25.
//

import SwiftUI

@MainActor
struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    @State private var showEmailSignIn = false
    @Binding var curUser: DBUser
    @Binding var curGift: ProductItem
    @Binding var update: Bool
    @Binding var authUser: AuthDataResultModel?
    
    var body: some View {
        ZStack {
            // Blue gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.4, green: 0.6, blue: 0.9),
                    Color(red: 0.2, green: 0.3, blue: 0.6)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 60) {
                Spacer()
                
                // Welcome text
                Text("Welcome")
                    .font(.system(size: 72, weight: .thin, design: .serif))
                    .foregroundColor(.white)
                    .tracking(8)
                
                Spacer()
                
                // Sign in button
                Button(action: {
                    showEmailSignIn = true
                }) {
                    Text("Sign in with email")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.5), lineWidth: 1.5)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.1))
                                )
                        )
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 80)
                
//                NavigationLink(destination: SignInEmailView(showSignInView: $showSignInView, curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser), isActive: $showEmailSignIn) {
//                    EmptyView()
//                }
            }
        }
        .navigationTitle("Sign In")
    }
}

