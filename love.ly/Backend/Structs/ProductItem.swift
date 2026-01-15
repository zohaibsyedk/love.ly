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

struct ProductItem: Codable {
    let senderId: String
    var started: Bool
    var startDate: Date?
    var receiverId: String?
    var compliments : [String]
    var complimentsStore: [String]
    var dateLast: Date?
    var complimentsGiven: [Date]?
    
    
    
    init(userId: String) {
        self.senderId = userId
        self.started = false
        self.startDate = nil
        self.receiverId = nil
        self.compliments = []
        self.complimentsStore = []
        
    }
    init() {
        self.senderId = "dummy"
        self.started = false
        self.startDate = nil
        self.receiverId = nil
        self.compliments = []
        self.complimentsStore = []
        
    }
    mutating func set(funz: String, data: Any) {
        if funz == "started" {
            self.started = (data as! Bool)
        }
        else if funz == "startDate" {
            self.startDate = (data as! Date)
        }
        else if funz == "receiverId" {
            self.receiverId = (data as! String)
        }
        else if funz == "compliments" {
            self.compliments = (data as! [String])
        }
        else if funz == "complimentsStore" {
            self.complimentsStore = [] as [String]
        }
        
    }
    
    mutating func addComplimentsStore(compliment: String) {
        guard !compliment.isEmpty else {
            print("Compliment Empty")
            return
        }
        self.complimentsStore.append(compliment.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    mutating func removeComplimentsStore(compliment: String) {
        self.complimentsStore.removeAll { $0 == compliment }
    }
    
    mutating func removeCompliments(compliment: String) {
        self.compliments.removeAll { $0 == compliment }
    }
    
    mutating func storeToCompliments() {
        self.compliments = self.complimentsStore.shuffled()
        self.complimentsStore = []
    }
}
