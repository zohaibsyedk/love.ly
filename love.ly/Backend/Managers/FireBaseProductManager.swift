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
            if let authDataResult = AuthenticationManager.shared.getAuthenticatedUser() {
                self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                self.userId = authDataResult.uid
            } else {
                throw NSError(domain: "ProductManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "loadCurrentUser Failed."])
            }
        } catch {
            throw NSError(domain: "ProductManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "loadCurrentUser Failed."])
        }
    }
    
    func snakeToCamel(_ input: String) -> String {
        let parts = input.split(separator: "_")
        let first = parts.first?.lowercased() ?? ""
        let rest = parts.dropFirst().map { $0.capitalized }
        return ([first] + rest).joined()
    }
    
    func dictTransform(data: [String : Any]) ->  [String : Any] {
        let newDict = Dictionary(uniqueKeysWithValues:
                                    data.map { (key, value) in
            (snakeToCamel(key), value)
        }
        )
        return newDict
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
        for _ in Range(0...2) {
            if let user = self.user { return user }
            else { try await _ = updateUser() }
        }
        throw NSError(domain: "ProductManager", code: 3, userInfo: [NSLocalizedDescriptionKey: "cant get user."])
        
    }
    private func checkHasProduct(userId: String) async throws -> Bool {
        let G = try await UserManager.shared.getUser(userId: userId)
        return G.productHolder
    }
    
    func creatProduct(uid: String) async throws {
        do {
            let hasProduct = try await checkHasProduct(userId: uid)
            if hasProduct {
                do {
                    if try await !isItemCreated(userId: uid){
                        let product: ProductItem = ProductItem(userId: uid)
                        try productDocumentRef(userId: uid).setData(from: product, merge: false, encoder: encoder)
                    } else {
                        print("product already created")
                    }
                } catch {
                    throw NSError(domain: "ProductManager", code: 6, userInfo: [NSLocalizedDescriptionKey: "createProduct Failed."])
                }
            } else {
                throw NSError(domain: "ProductManager", code: 6, userInfo: [NSLocalizedDescriptionKey: "doesnt own product"])
            }
        } catch {
            throw NSError(domain: "ProductManager", code: 6, userInfo: [NSLocalizedDescriptionKey: "checkProduct failed"])
        }
        
        
    }
    
    func getUsersProduct(uid: String) async throws -> ProductItem {
        var hasProd: Bool = false
        do {
            do {
                hasProd = try await checkHasProduct(userId: uid)
            } catch {
                throw NSError(domain: "ProductManager", code: 6, userInfo: [NSLocalizedDescriptionKey: "checkProduct failed"])
            }
            if hasProd == true {
                let productRef = self.productDocumentRef(userId: uid)
                let Product: ProductItem = try await productRef.getDocument(as: ProductItem.self,decoder: decoder)
                return Product
            } else {
                throw NSError(domain: "ProductManager", code: 7, userInfo: [NSLocalizedDescriptionKey: "User Does Not Own Product."])
            }
        } catch {
            throw NSError(domain: "ProductManager", code: 8, userInfo: [NSLocalizedDescriptionKey: "getUsersProduct Failed."])
        }
    }
    
    func getUsersProductId(userId: String) async throws -> ProductItem {
        do {
            let productRef = self.productDocumentRef(userId: userId)
            let Product: ProductItem = try await productRef.getDocument(as: ProductItem.self,decoder: decoder)
            return Product
        } catch {
            throw NSError(domain: "ProductManager", code: 8, userInfo: [NSLocalizedDescriptionKey: "getUsersProduct Failed."])
        }
    }
    
    func getUsersProductClaim(userId: String) async throws -> ProductItem {
        do {
            // Ensure the sender actually owns a product
            let sender = try await UserManager.shared.getUser(userId: userId)
            guard sender.productHolder else {
                throw NSError(domain: "ProductManager", code: 7, userInfo: [NSLocalizedDescriptionKey: "User Does Not Own Product."])
            }
            // Reference to the user's gift document
            let pr = Firestore.firestore()
                .collection("users")
                .document(userId)
                .collection("gifts")
                .document(userId)
            // Decode the document directly into ProductItem
            print(pr.path)
            let product = try await pr.getDocument()
            let p2 = createDB(dats: product.data()!)
            return p2
        } catch {
            throw NSError(domain: "ProductManager", code: 8, userInfo: [NSLocalizedDescriptionKey: "getUsersProduct Failed."])
        }
    }
    
    func createDB(dats: [String : Any]) -> ProductItem{
        let data = dictTransform(data: dats)
        let uid = data["senderId"] as? String
        var item = ProductItem(userId: uid!)
        for (key, value) in data {
            if key != "senderId" {
                item.set(funz: key, data: value)
            }
        }
        return item
        
    }
    
//    func getComplimentsStore(uid: String) async throws -> [String] {
//        do {
//            let compliments = try await getUsersProduct(uid: uid).complimentsStore
//            return compliments
//        } catch {
//            throw NSError(domain: "ProductManager", code: 9, userInfo: [NSLocalizedDescriptionKey: "getComplimentsStore Failed."])
//        }
//    }
    
    func isItemCreated(userId: String) async throws -> Bool{
        do{
            let snapshot = try await productDocumentRef(userId: userId).getDocument()
            return snapshot.exists
        } catch {
            return false
        }
    }
    
    func updateComplimentsStore(uid: String, documentData: [String]) async throws {
        do {
            let docRef = productDocumentRef(userId: uid)
            if try await !isItemCreated(userId: uid) {
                try await creatProduct(uid: uid)
            }
            let data = ComplimentsStoreUpdate(compliments: documentData)
            try docRef.setData(from: data, merge: true, encoder: encoder)
        } catch {
            throw NSError(domain: "ProductManager", code: 11, userInfo: [NSLocalizedDescriptionKey: "UpdateComplimentsStore Failed."])
        }
        
        
        
            
    }
    
    func claimItem(userId: String, myId: String, data: ProductItem) async throws {
        do {
            guard myId != "none" else {
                throw NSError(domain: "ProductManager", code: 11, userInfo: [NSLocalizedDescriptionKey: "User Not Authed"])
            }
            let docRef = productDocumentRef(userId: userId)
            if try await !isItemCreated(userId: userId) {
                throw NSError(domain: "ProductManager", code: 11, userInfo: [NSLocalizedDescriptionKey: "Product Doesnt Exist"])
            }
            try docRef.setData(from: data, merge: false, encoder: encoder)
            let dt = cFive()
            try await Firestore.firestore().collection("users").document(userId).collection("gifts").document(userId).updateData(["compliments_given" : [dt]])
            try await Firestore.firestore().collection("users").document(userId).updateData(["product_active" : true])
            try await Firestore.firestore().collection("users").document(myId).updateData(["product_receiving" : true , "sender_id" : userId, "type" : 6])
        } catch {
            throw NSError(domain: "ProductManager", code: 11, userInfo: [NSLocalizedDescriptionKey: "UpdateComplimentsStore Failed."])
        }
        
        
        
            
    }
    
    func signOutPush(gift: ProductItem, uid: String) throws {
        let ref = productDocumentRef(userId: uid)
        try ref.setData(from: gift, merge: false, encoder: encoder)
    }
    
    func endGift(gift: ProductItem) async throws {
        guard let rid = gift.receiverId else {throw NSError(domain: "ProductManager", code: 11, userInfo: [NSLocalizedDescriptionKey: "no rid in end gift"])}
        do {
            let sid = gift.senderId
            let docRef = productDocumentRef(userId: sid)
            let sendref = userDocument(userId: sid)
            let recref = userDocument(userId: rid)
            try sendref.collection("old_gifts").document(sid).setData(from: gift, merge: false, encoder: encoder)
            try sendref.collection("old_gifts").document(rid).setData(from: gift, merge: false, encoder: encoder)
            do {
                try await docRef.delete()
                print("Doc deleted Successfully")
            } catch {
                print("Error deleting doc")
            }
            try await sendref.setData(["product_holder" : false , "product_finished" : false, "product_active" : false], merge: true)
            try await recref.setData(["product_receiving" : false, "sender_id" : FieldValue.delete()], merge: true)
        }
        
        
    }
    
    func cFive() -> Date {
        let date = Date()
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        
        components.hour = 5
        components.minute = 0
        components.second = 0
        
        guard let earlier = calendar.date(from: components) else { return Date() }
        guard let later = calendar.date(byAdding: .day, value: -1, to: earlier) else { return Date() }
        let dif1 = abs(earlier.timeIntervalSince(date))
        let dif2 = abs(later.timeIntervalSince(date))
        if dif1 < dif2 { return earlier }
        else { return later }
    }
    
    func finalizeSetup(documentData: ProductItem, userId: String) async throws {
        do {
            let docRef = productDocumentRef(userId: userId)
            if try await !isItemCreated(userId: userId) {
                try await creatProduct(uid: userId)
            }
            let data = ComplimentsUpdate(itm: documentData)
            try docRef.setData(from: data, merge: true, encoder: encoder)
            try await userDocument(userId: userId).updateData(["product_finished" : true])
        } catch {
            print("Fail at firebase finalization")
            throw NSError(domain: "ProductManager", code: 11, userInfo: [NSLocalizedDescriptionKey: "UpdateComplimentsStore Failed."])
        }
        
        
        
            
    }
    
    
}

