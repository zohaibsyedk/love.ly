//
//  DBUser.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/9/26.
//

import Foundation
import FirebaseFirestore
import FirebaseSharedSwift


struct MyUser: Codable {
    let userId: String
    let email: String
    let firstName: String
    let lastName: String
    let dateCreated: Date
    var purchased: [String]
    var received: [String]
    
    
    init() {
        self.userId = "Error"
        self.email = "Error"
        self.firstName = "Error"
        self.lastName = "Error"
        self.dateCreated = Date()
        self.purchased = []
        self.received = []
        
    }
    
    init(auth: AuthDataResultModel, fName: String, lName: String) {
        self.userId = auth.uid
        self.email = auth.email!
        self.dateCreated = Date()
        self.firstName = fName
        self.lastName = lName
        self.purchased = []
        self.received = []
    }
    
    func isFake() -> Bool {
        return (self.userId == "Error")
    }
    
    
    
    
}
