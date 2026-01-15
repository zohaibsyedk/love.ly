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


final class FirebaseManager {
    
    
    static let shared = FirebaseManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    private let giftCollection = Firestore.firestore().collection("users")
    
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    private func giftDocument(productId: String) -> DocumentReference {
        giftCollection.document(productId)
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
    
    //F1
    func pushUser(user: MyUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: true, encoder: encoder)

    }
    
    
    //F2
    func pullUser(userId: String) async throws -> MyUser {
        let us = try await userDocument(userId: userId).getDocument(as: MyUser.self,decoder: decoder)
        return us
    }
    
    //F3
    func pushGift(gift: Gift) async throws {
        try giftDocument(productId: gift.productId).setData(from: gift, merge: true, encoder: encoder)

    }
    
    
    //F4
    func pullGift(productId: String) async throws -> Gift {
        let us = try await giftDocument(productId: productId).getDocument(as: Gift.self,decoder: decoder)
        return us
    }
    
    //`func onPurchase
    
    
}
//OperationResult<GetUserByUidQuery.Data
