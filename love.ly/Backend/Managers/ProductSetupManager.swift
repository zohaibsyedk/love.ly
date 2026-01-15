//
//  ProductSetupManager.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/22/25.
//

import Foundation
internal import Combine


@MainActor
final class ProductSetupManager: ObservableObject {
    
    
    
    static let shared = ProductSetupManager()
    init() {}
    
    
    func saveProgress(uid: String, cstore: [String]) async throws -> Bool {
        do {
            guard uid != "none" else {
                throw NSError(domain: "ProductSetupManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "saveProgress Failed."])
            }
            try await FireBaseProductManager.shared.updateComplimentsStore(uid: uid, documentData: cstore)
            return true
        } catch {throw NSError(domain: "ProductSetupManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "saveProgress Failed."])}
        
        
    }
    
    func finalizeSetup(num: Int, uid: String, gift: ProductItem) async throws -> Bool {
        do {
            if num >= 0 {
                try await FireBaseProductManager.shared.finalizeSetup(documentData: gift, userId: uid)
                return true
            } else {return false}
        } catch {return false}
    }
    
    

    
    
    
    
    
}
