//
//  SettingsView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/18/25.
//

import SwiftUI
internal import Combine


struct SettingsView: View {
    
    @EnvironmentObject var giftData: GiftData
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    @State private var hideTabBar: Bool = false
    @State private var onAppearRan: Bool = false
    @Binding var curUser: DBUser
    @Binding var curGift: ProductItem
    @Binding var update: Bool
    @Binding var authUser: AuthDataResultModel?
    @Binding var activeTab: AppTab

    @MainActor
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
    
    @MainActor
    func signOut() throws {
        if let utype = curUser.type {
            if utype  == 5 {
                giftData.signOut()
            }
            else if utype == 6 {
                if let sid = curUser.senderId {
                    do {
                        try FireBaseProductManager.shared.signOutPush(gift: giftData.gift, uid: sid)
                        giftData.signOut()
                    } catch {
                        print("Failed to save product")
                    }
                } else {
                    print("No sid")
                }
            }
        }
        try AuthenticationManager.shared.signOut()
    }

    var body: some View {
        NavigationStack {
            List {
                Button("Log Out") {
                    Task {
                        do {
                            try signOut()
                            curUser = DBUser()
                            curGift = ProductItem()
                            authUser = nil
                            showSignInView = true
                            
                        } catch{
                            print(error)
                        }
                    }
                };
                Button("Toggle Tab Bar") {
                    hideTabBar.toggle()
                }
            }
            .navigationTitle("Settings")
        }
        .onAppear {
            if authUser == nil {
                authUser =  AuthenticationManager.shared.getAuthenticatedUser()
                if authUser == nil {
                    showSignInView = true
                }
            }
            
            if update {
                Task {
                    try await updateCondensed(view: "SettingsView", place:  "onAppear")
                }
            }
            onAppearRan = true
        }

        
        .hideFloatingBar(hideTabBar)
    }
}
