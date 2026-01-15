////
////  DataConnectFunctionModels.swift
////  love.ly
////
////  Created by Zohaib Syed on 1/7/26.
////
//import Foundation
//import FirebaseFirestore
//import FirebaseSharedSwift
//import FirebaseDataConnect
//import DataConnectGenerated
//import Combine
//
//struct UserInfo: Codable {
//    var id: String!
//    var productHolderId: String
//    var productReceivingId: String
//    var email: String!
//    var dateCreated: Date!
//    var productActive: Boolean!
//    var productFinished: Boolean!
//    var productHolder: String
//    var productRecieving: String
//    
//    init(auth: AuthDataResultModel) {
//        self.id = auth.uid
//        self.email = auth.email
//        self.dateCreated = Date()
//        self.productActive = false
//        self.productFinished = false
//    }
//    
//    
//    init(dbresult: DataConnectResult<GetUserData, GetUserVariables>) {
//        self.id = dbresult.data.id
//        self.productHolderId = dbresult.data.productHolderId ?? nil
//        self.productReceivingId = dbresult.data.productReceivingId ?? nil
//        self.email = dbresult.data.email
//        self.dateCreated = dbresult.data.dateCreated.dateValue()
//        self.productActive = dbresult.data.productActive
//        self.productFinished = dbresult.data.productFinished
//        self.productHolder = dbresult.data.productHolder.id ?? nil
//        self.productRecieving = dbresult.data.productReceiving.id ?? nil
//    }
//    
//    init(dbresult: DataConnectResult<GetOtherUserData, GetOtherUserVariables>) {
//        self.id = dbresult.data.id
//        self.productHolderId = dbresult.data.productHolderId ?? nil
//        self.productReceivingId = dbresult.data.productReceivingId ?? nil
//        self.email = dbresult.data.email
//        self.dateCreated = dbresult.data.dateCreated.dateValue()
//        self.productActive = dbresult.data.productActive
//        self.productFinished = dbresult.data.productFinished
//        self.productHolder = dbresult.data.productHolder.id ?? nil
//        self.productReceiving = dbresult.data.productReceiving.id ?? nil
//    }
//    
//    mutating func addProduct() {
//        self.productHolder = true
//    }
//    
//}
//
//
//final class DataConnectFunctionModels {
//    
//    
//    static let shared = UserManager()
//    @Published private(set) var user: UserInfo
//    @Published private(set) var userId: String
//    private init() {}
//    
//    let connector = DataConnect.lovelyConnector
//    
//    func getOtherUser(id: String) async throws -> UserInfo {
//        let result = try await connector.getUserQuery.execute(id: id)
//        if let data = result.data {
//            let jsonData  = try JSONEncoder().encode(data)
//            let user = try JSONDecoder().decode(UserInfo.self, from: jsonData)
//            return user
//        }
//    }
//    
//    func getUser() async throws -> UserInfo {
//        let result = try await connector.getUserQuery.execute()
//        if let data = result.data {
//            let jsonData  = try JSONEncoder().encode(data)
//            let user = try JSONDecoder().decode(UserInfo.self, from: jsonData)
//            return user
//        }
//    }
//    
//    func loadUserAuth() async throws -> UserInfo {
//        do {
//            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
//            self.user = try await getOtherUser(id: authDataResult.uid)
//            self.userId = authDataResult.uid
//        } catch {
//            throw NSError(domain: "ProductManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "loadCurrentUser Failed."])
//        }
//    }
//    
//    func createUser() async throws -> Bool {
//        do {
//            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
//            let usr = UserInfo(auth: authDataResult)
//            let result = try await connector.createUserMutation.execute(
//                id: usr.id,
//                email: usr.email,
//                dateCreated: Timestamp(date: usr.dateCreated),
//                productActive: usr.productActive,
//                productFinished: usr.productFinished
//            )
//            return true
//        } catch {
//            return false
//        }
//      
//    }
//    
//    func createProduct() async throws -> String {
//        do {
//            let usr = loadUserAuth()
//            let _ = try await connector.createComplimentProductMutation.execute(senderId: usr.id, compliments: [], complimentStore: [])
//            let result = try await connector.getUsersGiftQuery.execute(id: usr.id)
//            let _ = try await connector.linkProductToCreatorMutation.execute(userId: usr.id, productId: result.data.id)
//            return result.data.id
//        } catch {
//            throw NSError(domain: "ProductManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "loadCurrentUser Failed."])
//        }
//    }
//    
//    func claimProduct(id: String) async throws -> Bool {
//        do {
//            let ths = loadUserAuth()
//            let _ = try await connector.startComplimentProductMutation.execute(productId: id)
//            let _ = try await connector.linkProductToReceiverMutation.execute(userId: ths.id, productId: id)
//            let _ = try await connector.linkReceiverToProductMutation.execute(userId: ths.id, productId: id)
//            let gift = try await connector.getGiftQuery.execute(id: id)
//            let _ = try await connector.updateProductActiveMutation.execute(userId: gift.data.sender.id, productActive: true)
//            return true
//        } catch {
//            return false
//        }
//    }
//    
//    func updateCompliments(compliments: [String]) async throws -> Bool {
//        do {
//            let ths = loadUserAuth()
//            guard ths.productHolder != nil else { return false }
//            let gift = try await connector.getUsersGiftQuery.execute(id: ths.id)
//            let _ = try await connector.updateComplimentsMutation.execute(productId: gift.data.id, newCompliments: compliments)
//            return true
//        } catch {
//            return false
//        }
//    }
//    
//    func updateComplimentStore(compliments: [String]) async throws -> Bool {
//        do {
//            let ths = loadUserAuth()
//            guard ths.productHolder != nil else { return false }
//            let gift = try await connector.getUsersGiftQuery.execute(id: ths.id)
//            let _ = try await connector.updateComplimentStoreMutation.execute(productId: gift.data.id, newCompliments: compliments)
//            return true
//        } catch {
//            return false
//        }
//    }
//    
//    func finishProduct() async throws -> Bool {
//        do {
//            let ths = loadUserAuth()
//            guard ths.productHolder != nil else { return false }
//            let _ = try await connector.updateProductFinishedMutation.execute(id: ths.id, productFinished: true)
//            return true
//        } catch {
//            return false
//        }
//    }
//    
//}
//
