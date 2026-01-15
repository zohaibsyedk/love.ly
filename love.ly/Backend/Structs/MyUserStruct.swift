////
////  MyUserStruct.swift
////  love.ly
////
////  Created by Zohaib Syed on 1/9/26.
////
//
//import Foundation
//import Foundation
//import FirebaseFirestore
//import FirebaseSharedSwift
//
//struct MyUser: Codable {
//    let userId: String
//    let email: String?
//    var type: Int
//    var gift: MyGift?
//    // 1. Default, 2. Sender Not Started, 3. Sender IP, 4. Sender Finished, 5. Sender Claimed, 6. Receiver
//    
//    init(usr: DBUser) {
//        self.userId = usr.userId
//        self.email = usr.email
//        if usr.productReceiving == true { self.type = 6 }
//        else if usr.productActive == true { self.type = 5 }
//        else if usr.productFinished == true { self.type = 4 }
//        else if usr.productHolder == true { self.type = 7 }
//        else { self.type = 1}
//    }
//    
//    
////    mutating func initialize() async throws {
////        if self.type == 1 { self.gift = MyGift() }
////        else {
////            if ((self.type >= 2) && (self.type <= 5)) || (self.type == 7) {
////                let gifts = try await FireBaseProductManager.shared.getUsersProduct()
////                if self.type == 7 {
////                    if gifts.complimentsStore.isEmpty { self.type = 2}
////                    else { self.type = 3 }
////                }
////                self.gift = MyGift(prod: gifts)
////            } else {
////                
////            }
////        }
////    }
//    
//}
