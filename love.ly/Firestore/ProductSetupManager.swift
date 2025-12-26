//
//  ProductSetupManager.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/22/25.
//

import Foundation
internal import Combine


struct ProductItemLocal: Codable {
    var complimentsStore: [String: [String]]
    var prompts: [String]
    var promptsResponse: [String : String]
    
    
    init(item: ProductItem) {
        self.complimentsStore = item.complimentsStore
        self.prompts = item.prompts
        self.promptsResponse = item.promptsResponse
        
    }
    init() {
        self.complimentsStore = [
            "personality": [], "appearence": [], "Insecurity": [], "dreams": [],
            "smallthings": [], "hobbies": [], "songs": [], "future": [], "talents": [], "other": []
        ]
        self.prompts = []
        self.promptsResponse = [:]
    }
    
    mutating func loadProgress() async throws{
        let item = try await FireBaseProductManager.shared.getUsersProduct()
        self.complimentsStore = item.complimentsStore
        self.prompts = item.prompts
        self.promptsResponse = item.promptsResponse
    }
}

@MainActor
final class ProductSetupManager: ObservableObject {
    
    @Published var complimentsStore: [String: [String]] = [:]
    @Published var prompts: [String] = []
    @Published var promptsResponse: [String : String] = [:]
    @Published var current: String = ""
    @Published var counts: Int = 0
    
    static let shared = ProductSetupManager()
    init() {
        self.complimentsStore = [:]
        self.prompts = []
        self.promptsResponse = [:]
        self.current = ""
        self.counts = 0
    }
    
    func removeCompliment(set: String, compliment: String) {
        self.complimentsStore[set]?.removeAll { $0 == compliment }
    }
    
    func loadProgress() async throws {
        do {
            let item = try await FireBaseProductManager.shared.getUsersProduct()
            self.complimentsStore = item.complimentsStore
            self.prompts = item.prompts
            self.promptsResponse = item.promptsResponse
            self.counts = item.complimentsStore.count
        } catch { return }
        
    }
    
    func addComplimentsStage(prompt: String) {
        self.complimentsStore[prompt, default: []].append(self.current)
        self.current = ""
    }
    
    func addPromptsStage(prompt: String) {
        self.prompts.append(prompt)
    }
    
    func addPromptResponse(prompt: String, response: String){
        self.promptsResponse[prompt] = response
    }
    
    func saveProgress() async throws -> Bool {
        do {
            try await FireBaseProductManager.shared.updateComplimentsStore(documentData: self.complimentsStore)
            return true
        } catch {throw NSError(domain: "ProductSetupManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "saveProgress Failed."])}
        
        
    }
    
    func finalizeSetup() async throws -> Bool {
        do {
            if self.counts >= 0 {
                try await FireBaseProductManager.shared.finalizeSetup(documentData: self.complimentsStore)
                self.complimentsStore = [:]
                return true
            } else {return false}
        } catch {return false}
    }
    

    
    
    
    
    
}
