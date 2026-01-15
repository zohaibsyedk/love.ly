//
//  ProductItem.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/9/26.
//

import Foundation
import FirebaseFirestore
import FirebaseSharedSwift
internal import Combine

struct Gift: Codable {
    let productId: String
    var compliments : [String]
    var active: Bool?
    var startDate: Date?
    var endDate: Date?
    var senderId: String
    var receiverId: String?
    
    
    
    init(productId: String, senderId: String) {
        self.productId = productId
        self.senderId = senderId
        self.compliments = []
        
    }
    init() {
        self.senderId = "dummy"
        self.productId = "dummy"
        self.compliments = []
        
    }
    
    func isFake() -> Bool {
        return (self.senderId == "dummy")
    }

}
