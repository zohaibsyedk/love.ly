//
//  SigninEmailView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/18/25.
//

import SwiftUI
internal import Combine

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    @Binding var curUser: DBUser
    @Binding var curGift: ProductItem
    @Binding var update: Bool
    @Binding var authUser: AuthDataResultModel?
    @Binding var currentScreen: BackgroundView.Screen
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 15) {
            
            VStack(alignment: .leading) {
                Button(action: {
                    currentScreen = .authen
                }) {
                    Image(systemName: "chevron.left")
                        
                }
                .buttonStyle(SmallButtonWhiteStyle())
                .padding(.top, 5)
                .padding(.leading, 30)
            }
            
            Spacer()
                .frame(height: 180)
            
            // Title
            VStack(alignment: .center, spacing: 20) {
                Text("Sign In")
                    .font(.custom("Lexend-Bold", size: 32))
                    // Fallback in case font isn't loaded
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(alignment: .center, spacing: 8) {
                    // Sign In Button
                    TextField("Email...", text: $viewModel.email)
                        .textFieldStyle(TextFieldBlackStyle())
                    
                    SecureField("Password...", text: $viewModel.password)
                        .textFieldStyle(TextFieldBlackStyle())
                    
                    Button("Sign In") {
                        Task {
                            do {
                                authUser = try await viewModel.signIn()
                                showSignInView = false
                                update = true
                                return
                            } catch {
                                print(error)
                            }
                            
                            do {
                                authUser = try await viewModel.signUp()
                                showSignInView = false
                                update = true
                                return
                            } catch {
                                print(error)
                            }
                            print("Error with SignIn/SignUp)")
                            
                        }
                    }
                    .buttonStyle(ButtonWhiteStyle())
               
                }
                
            }
            .padding(.bottom, 10)
            
            // Buttons
            
            .padding(.horizontal, 30) // Controls how wide the buttons are
            
            Spacer()
        }
    }
        
}


