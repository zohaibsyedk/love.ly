//
//  SignInEmailViewModel.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import Foundation
internal import Combine
import Firebase


@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws -> AuthDataResultModel {
        guard !email.isEmpty, !password.isEmpty else {
            throw NSError(domain: "SignInModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Email or Password"])
        }
        
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        try await UserManager.shared.createNewUser(auth: authDataResult)
        guard let ath =  AuthenticationManager.shared.getAuthenticatedUser() else {
            throw NSError(domain: "SignInModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed Sign Up"])
        }
        return ath
    }
    
    func signIn() async throws -> AuthDataResultModel {
        guard !email.isEmpty, !password.isEmpty else {
            throw NSError(domain: "SignInModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Email or Password"])
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
        guard let ath =  AuthenticationManager.shared.getAuthenticatedUser() else {
            throw NSError(domain: "SignInModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed Sign In"])
        }
        return ath
       
    }
}

