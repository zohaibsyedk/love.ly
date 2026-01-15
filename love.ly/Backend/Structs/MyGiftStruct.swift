//
//  MyGiftStruct.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/9/26.
//

import Foundation
import FirebaseFirestore
import FirebaseSharedSwift

struct MyGift: Codable {
    var exists: Bool
    var compliments: [String]?
    var complimentsStore: [String]?
    var startDate: Date?
    
    init() {
        self.exists = false
    }
    
    init(prod: ProductItem) {
        self.exists = true
        self.compliments = prod.compliments
        self.complimentsStore = prod.complimentsStore
        if prod.startDate != nil { self.startDate = prod.startDate }
    }
    
    
}
