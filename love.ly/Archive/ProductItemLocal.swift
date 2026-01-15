////
////  ProductItemLocal.swift
////  love.ly
////
////  Created by Zohaib Syed on 1/9/26.
////
//
//import Foundation
//internal import Combine
//
//
//struct ProductItemLocal: Codable {
//    var complimentsStore: [String]
//    var prompts: [String]
//    var promptsResponse: [String : String]
//    
//    
//    init(item: ProductItem) {
//        self.complimentsStore = item.complimentsStore
//
//        
//    }
//    init() {
//        self.complimentsStore = []
//        self.prompts = []
//        self.promptsResponse = [:]
//    }
//    
////    mutating func loadProgress() async throws{
////        let item = try await FireBaseProductManager.shared.getUsersProduct()
////        self.complimentsStore = item.complimentsStore
////        self.prompts = item.prompts
////        self.promptsResponse = item.promptsResponse
////    }
//}
