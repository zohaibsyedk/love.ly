//
//  DBUser.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/9/26.
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
    var productReceiving: Bool?
    var senderId: String?
    var type: Int?
    var hasOldGifts: Bool
    
    
    init() {
        self.userId = "Error"
        self.email = "Error"
        self.photoUrl = "Error"
        self.dateCreated = Date()
        self.productHolder = false
        self.productFinished = false
        self.productActive = false
        self.productReceiving = false
        self.type = 10
        self.hasOldGifts = false
    }
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.productHolder = false
        self.productFinished = false
        self.productActive = false
        self.productReceiving = false
        self.type = 10
        self.hasOldGifts = false
    }
    
    // 1. Default, 2. Sender Not Started, 3. Sender IP, 4. Sender Finished, 5. Sender Claimed, 6. Receiver
    mutating func addProduct() {
        self.productHolder = true
    }
    
    mutating func addSenderId(_ senderId: String) {
        self.senderId = senderId
    }
    
    mutating func setType(){
        if self.productReceiving == true { self.type = 6 }
        else if self.productActive == true { self.type = 5 }
        else if self.productFinished == true { self.type = 4 }
        else if self.productHolder == true { self.type = 7 }
        else { self.type = 1}
    }
    
    mutating func initialize(gift: ProductItem) {
        self.setType()
        if self.type == 7 {
            if gift.complimentsStore.isEmpty {
                self.type = 2
            } else {
                self.type = 3
            }
        }
        
    }
    
    
    
    
}
