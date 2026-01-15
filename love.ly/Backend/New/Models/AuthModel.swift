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
final class AuthModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var firstName = ""
    @Published var lastName = ""
    
    func signUp() async throws -> MyUser {
        guard !email.isEmpty, !password.isEmpty, !firstName.isEmpty, !lastName.isEmpty else {
            throw NSError(domain: "SignInModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Email or Password"])
        }
        let newUser = try await AuthManager.shared.signUp(email: email, password: password, fName: firstName, lName: lastName)
        return newUser
    }
    
    func signIn() async throws -> MyUser {
        guard !email.isEmpty, !password.isEmpty else {
            throw NSError(domain: "SignInModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Email or Password"])
        }
        
        let newUser = try await AuthManager.shared.signIn(email: email, password: password)
        guard let ath =  AuthenticationManager.shared.getAuthenticatedUser() else {
            throw NSError(domain: "SignInModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Email or Password"])
        }
        return newUser
       
    }
}

