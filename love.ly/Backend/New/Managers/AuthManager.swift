//
//  AuthenticationManager.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/15/26.
//
import Foundation
import FirebaseAuth


final class AuthManager {
    
    static let shared = AuthManager()
    private init() { }
    
    func getAuthenticatedUser() -> AuthDataResultModel? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func AuthUID() -> String? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        return user.uid
    }
    
    func signUp(email: String, password: String, fName: String, lName: String) async throws -> MyUser {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        guard let cur = getAuthenticatedUser() else {
            throw NSError(domain: "SignInModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed Sign Up"])
        }
        let mod = AuthDataResultModel(user: authDataResult.user)
        let usr = MyUser(auth: mod, fName: fName, lName: lName)
        try await FirebaseManager.shared.pushUser(user: usr)
        return usr
    }
    
    func signIn(email: String, password: String) async throws -> MyUser {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        guard let cur = getAuthenticatedUser() else {
            throw NSError(domain: "SignInModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed Sign Up"])
        }
        let usr = try await FirebaseManager.shared.pullUser(userId: authDataResult.user.uid)
        return usr
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
