//
//  ProductClaimView.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/2/26.
//

import SwiftUI
import Foundation
internal import Combine
import FirebaseFirestore

final class ProductClaimModel: ObservableObject {
    static let shared = ProductClaimModel()
    init(){}
    
    func getItem(userId: String) async throws -> ProductItem {
        try await FireBaseProductManager.shared.getUsersProductClaim(userId: userId)
    }
    func claimGift(userId: String) async throws -> ProductItem {
        var item = try await getItem(userId: userId)
        let user = try await FireBaseProductManager.shared.getUser()
        item.started = true
        item.receiverId = user.userId
        item.startDate = Date()
        

        return item
    }
}


struct ProductClaimView: View {
    
    @EnvironmentObject var giftData: GiftData
    @Binding var sendId: String
    @Binding var showClaim: Bool
    @Binding var curUser: DBUser
    @Binding var curGift: ProductItem
    @Binding var update: Bool
    @Binding var authUser: AuthDataResultModel?
    //@Binding var loaded: Bool
    
    
    func updateCondensed(view: String, place: String) async throws {
        
        do {
            curUser = try await RootModel.shared.updateUser(ath: authUser)
            print("Success: [User Update] \(view) .\(place)")
            do {
                curGift = try await RootModel.shared.updateGift(user: curUser)
                curUser.initialize(gift: curGift)
                print("Success: [Gift Update] \(view) .\(place)")
                update = false
            } catch {
                print("Fail: [Gift Update] \(view) .\(place)")
            }
        } catch {
            print("Fail: [User Update] \(view) .\(place)")
        }
        if (((curUser.productActive == nil) || (curUser.productActive == false)) || (curUser.productReceiving == true)) && giftData.gift.senderId == "dummy" {
            giftData.setGift(curGift)
        }
    }
    
    var body: some View {
        
        VStack {
            Text(sendId)
            Button("Claim Gift"){
                Task{
                    do{
                        try await FireBaseProductManager.shared.claimItem(userId: sendId, myId: authUser?.uid ?? "none", data: ProductClaimModel.shared.claimGift(userId: sendId))
                        try await updateCondensed(view: "ClaimView", place: "OnClaim")
                        showClaim = false
                        
                        return
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

