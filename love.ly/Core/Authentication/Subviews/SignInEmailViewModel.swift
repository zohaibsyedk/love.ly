//
//  SignInEmailViewModel.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import Foundation
internal import Combine

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw NSError(domain: "SignInModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Email or Password"])
        }
        
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = DBUser(auth: authDataResult)
        try UserManager.shared.createNewUser(user: user)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw NSError(domain: "SignInModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Email or Password"])
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
       
    }
}

