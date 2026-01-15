//
//  RootModel.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/9/26.
//
import Foundation
internal import Combine
import Firebase
import FirebaseAuth


final class RootModel: ObservableObject {
    
    static let shared = RootModel()
    init(){
    }
    
    func updateGift(user: DBUser) async throws -> ProductItem {
        if (user.userId == "Error") || ((user.productHolder == false) && (user.productReceiving == false)) {
            return ProductItem()
        } else {
            if let sid = user.senderId {
                do{
                    print("trying to update gift for receiver")
                    let gift = try await FireBaseProductManager.shared.getUsersProductId(userId: sid)
                    return gift
                } catch {
                    print("Failed to update gift receiver")
                    return ProductItem()
                }
                
            } else {
                do {
                    print("trying to update gift for sender")
                    let gift = try await FireBaseProductManager.shared.getUsersProductId(userId: user.userId)
                    return gift
                } catch {
                    print("Failed to update gift sender")
                    return ProductItem()
                }
                
            }
        }
    }
    
//    func updateGift() async throws -> ProductItem {
//        do {
//            let gft = try await FireBaseProductManager.shared.getUsersProduct()
//            return gft
//        } catch {return ProductItem()}
//    }
//    
    
    func updateUser(ath: AuthDataResultModel?) async throws -> DBUser {
        do {
            if let at = ath {
                var usr = try await UserManager.shared.getUser(userId: at.uid)
                print("user received from Db")
                usr.setType()
                print("type set")
                return usr
            } else {
                print("no auth")
                return DBUser()
            }
            
        } catch {
            print("Cant get auth user")
            return DBUser()
        }
        
    }
    

    

    
}
