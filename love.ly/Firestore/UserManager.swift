//
//  UserManager.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import Foundation
import FirebaseFirestore
import FirebaseSharedSwift

struct DBUser: Codable {
    let userId: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    var productHolder: Bool
    var productFinished: Bool
    var productActive: Bool?
    var productRecieving: Bool?
    
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.productHolder = false
        self.productFinished = false
        self.productActive = false
        self.productRecieving = false
    }
    
    mutating func addProduct() {
        self.productHolder = true
    }
    
}

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
    
    func createNewUser(user: DBUser) throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)

    }
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        let user = DBUser(auth: auth)
        try createNewUser(user: user)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self,decoder: decoder)
    }
    
    func buyProduct(userId: String) async throws {
        let news: [String: Any] = [
            "product_holder": true
        ]
        try await userDocument(userId: userId).updateData(news)
    }
    
}
