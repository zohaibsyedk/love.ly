//
//  ProductManager.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import Foundation
import FirebaseFirestore
import FirebaseSharedSwift
internal import Combine

struct ProductItem: Codable {
    let senderId: String
    var started: Bool
    var startDate: Date?
    var recieverId: String?
    var compliments : [String]
    var complimentsStore: [String]
    var prompts: [String]
    var promptsResponse: [String : String]
    
    
    init(userId: String) {
        self.senderId = userId
        self.started = false
        self.compliments = []
        self.complimentsStore = []
        self.prompts = []
        self.promptsResponse = [:]
        
    }
}

struct ComplimentsStoreUpdate: Codable {
    var complimentsStore: [String]
    init (compliments: [String]) {
        self.complimentsStore = compliments
    }
}

struct ComplimentsUpdate: Codable {
    var compliments: [String]
    var complimentsStore: [String]
    init (compliments: [String]) {
        self.compliments = compliments
        self.complimentsStore = []
    }
}


@MainActor
final class FireBaseProductManager {
    static let shared = FireBaseProductManager()
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var userId: String? = nil
    private init () {}
    

    
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
    
    
    private func loadCurrentUser() async throws {
        do {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
            self.userId = authDataResult.uid
        } catch {
            throw NSError(domain: "ProductManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "loadCurrentUser Failed."])
        }
    }

    private func userDocument(userId: String) -> DocumentReference {
        Firestore.firestore().collection("users").document(userId)
    }
    
    private func productDocumentRef(userId: String) -> DocumentReference {
        userDocument(userId: userId).collection("gifts").document(userId)
    }
    
    func updateUser() async throws -> String {
        do {
            if user == nil {
                try await loadCurrentUser()
            }
            guard let userId = user?.userId else {
                throw NSError(domain: "ProductManager", code: 2, userInfo: [NSLocalizedDescriptionKey: "User ID is missing."])
            }
            return userId
        } catch {
            throw NSError(domain: "ProductManager", code: 3, userInfo: [NSLocalizedDescriptionKey: "updateUser Failed."])
        }
    }
    
    func getUser() async throws  -> DBUser {
        for i in Range(0...2) {
            if let user = self.user { return user }
            else { try await _ = updateUser() }
        }
        throw NSError(domain: "ProductManager", code: 3, userInfo: [NSLocalizedDescriptionKey: "cant get user."])
        
    }
    private func checkHasProduct(userId: String) async throws -> Bool {
        return self.user?.productHolder ?? false
    }
    
    func creatProduct() async throws {
        do {
            let userId = try await updateUser()
            if try await checkHasProduct(userId: userId){
                if try await !isItemCreated(userId: userId){
                    let product: ProductItem = ProductItem(userId: userId)
                    try productDocumentRef(userId: userId).setData(from: product, merge: false, encoder: encoder)
                } else {
                    throw NSError(domain: "ProductManager", code: 4, userInfo: [NSLocalizedDescriptionKey: "Item Already Created."])
                }
            } else {throw NSError(domain: "ProductManager", code: 5, userInfo: [NSLocalizedDescriptionKey: "User Does Not Own Product."])}
        } catch {
            throw NSError(domain: "ProductManager", code: 6, userInfo: [NSLocalizedDescriptionKey: "createProduct Failed."])
        }
        
    }
    
    func getUsersProduct() async throws -> ProductItem {
        do {
            let userId = try await updateUser()
            if try await checkHasProduct(userId: userId) {
                let productRef = self.productDocumentRef(userId: userId)
                let Product: ProductItem = try await productRef.getDocument(as: ProductItem.self,decoder: decoder)
                return Product
            } else {
                throw NSError(domain: "ProductManager", code: 7, userInfo: [NSLocalizedDescriptionKey: "User Does Not Own Product."])
            }
        } catch {
            throw NSError(domain: "ProductManager", code: 8, userInfo: [NSLocalizedDescriptionKey: "getUsersProduct Failed."])
        }
    }
    
    func getComplimentsStore() async throws -> [String] {
        do {
            let compliments = try await getUsersProduct().complimentsStore
            return compliments
        } catch {
            throw NSError(domain: "ProductManager", code: 9, userInfo: [NSLocalizedDescriptionKey: "getComplimentsStore Failed."])
        }
    }
    
    func isItemCreated(userId: String) async throws -> Bool{
        do{
            let snapshot = try await productDocumentRef(userId: userId).getDocument()
            return snapshot.exists
        } catch {
            throw NSError(domain: "ProductManager", code: 10, userInfo: [NSLocalizedDescriptionKey: "isItemCreated Failed."])
        }
    }
    
    func updateComplimentsStore(documentData: [String]) async throws {
        do {
            let userId = try await updateUser()
            let docRef = productDocumentRef(userId: userId)
            if try await !isItemCreated(userId: userId) {
                try await creatProduct()
            }
            let data = ComplimentsStoreUpdate(compliments: documentData)
            try docRef.setData(from: data, merge: true, encoder: encoder)
        } catch {
            throw NSError(domain: "ProductManager", code: 11, userInfo: [NSLocalizedDescriptionKey: "UpdateComplimentsStore Failed."])
        }
        
        
        
            
    }
    
    func finalizeSetup(documentData: [String]) async throws {
        do {
            let userId = try await updateUser()
            let docRef = productDocumentRef(userId: userId)
            if try await !isItemCreated(userId: userId) {
                try await creatProduct()
            }
            let data = ComplimentsUpdate(compliments: documentData)
            try docRef.setData(from: data, merge: true, encoder: encoder)
        } catch {
            throw NSError(domain: "ProductManager", code: 11, userInfo: [NSLocalizedDescriptionKey: "UpdateComplimentsStore Failed."])
        }
        
        
        
            
    }
    
    
}

