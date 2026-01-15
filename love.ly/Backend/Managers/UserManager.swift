//
//  UserManager.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import Foundation
import FirebaseFirestore
import FirebaseSharedSwift
import FirebaseAuth


final class UserManager {
    
    
    static let shared = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)

    }
    
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        let user = DBUser(auth: auth)
        try await createNewUser(user: user)
    }
    
    func getUser(userId: String) async throws -> DBUser {

        let us = try await userDocument(userId: userId).getDocument(as: DBUser.self,decoder: decoder)
        return us
    }
    
    
    func buyProduct(userId: String) async throws {
        let news: [String: Any] = [
            "product_holder": true
        ]
        try await userDocument(userId: userId).updateData(news)
        try await FireBaseProductManager.shared.creatProduct(uid: userId)
    }
    
}
//OperationResult<GetUserByUidQuery.Data
