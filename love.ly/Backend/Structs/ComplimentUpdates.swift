//
//  ComplimentUpdates.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/9/26.
//

import Foundation
import FirebaseFirestore
import FirebaseSharedSwift
internal import Combine


struct ComplimentsStoreUpdate: Codable {
    var complimentsStore: [String]
    init (compliments: [String]) {
        self.complimentsStore = compliments
    }
    init (itm: ProductItem) {
        self.complimentsStore = itm.complimentsStore
    }
}

struct ComplimentsUpdate: Codable {
    var compliments: [String]
    var complimentsStore: [String]
    init (compliments: [String]) {
        self.compliments = compliments.shuffled()
        self.complimentsStore = []
    }
    init (itm: ProductItem) {
        self.compliments = itm.compliments
        self.complimentsStore = itm.complimentsStore
        
    }
    
}
