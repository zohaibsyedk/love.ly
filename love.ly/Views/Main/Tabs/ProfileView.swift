//
//  ProfileView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import SwiftUI
internal import Combine
import FirebaseAuth

struct ProfileView: View {
    
    @EnvironmentObject var giftData: GiftData
    @Binding var showSignInView: Bool
    @State private var showClaim = false
    @State private var selected = "compliments"
    @State var onAppearRan: Bool = false
    @Binding var curUser: DBUser
    @Binding var curGift: ProductItem
    @Binding var update: Bool
    @Binding var authUser: AuthDataResultModel?
    @Binding var activeTab: AppTab
    @State var select: Date = Date()
    
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
    
    var body: some View {
        ZStack {
            PinkPurpleBackground()
            VStack(alignment: .leading, spacing: 8) {
                Text("Home")
                    .font(.custom("Lexend-Bold", size: 40))
                    // Fallback in case font isn't loaded
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                
                VStack(alignment: .center) {
                    
                    ProfileCardView(curUser: $curUser, curGift: $curGift, update: $update, activeTab: $activeTab)
                    
                }
            }
            
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
                    try await updateCondensed(view: "ProfileView", place:  "onAppear")
                }
            }
            onAppearRan = true
            if giftData.gift.dateLast != nil {
                select = giftData.gift.dateLast!
            }
        }
        .onChange(of: authUser?.uid) { old, new in
            update = true
            if giftData.gift.dateLast != nil {
                select = giftData.gift.dateLast!
            }
        }
        
        .onChange(of: update) { old, new in
            if new == true {
                Task {
                    try await updateCondensed(view: "ProfileView", place:  "onChange")
                }
                if giftData.gift.dateLast != nil {
                    select = giftData.gift.dateLast!
                }
            }
        }
//        Form {
//            Button("Refresh"){
//                Task {
//                    authUser =  AuthenticationManager.shared.getAuthenticatedUser()
//                    update = true
//                }
//            }
//            if curUser.userId != "Error" {
//                if (curUser.type == 5) || (curUser.type == 6) {
//                    
//                    if curUser.type == 5 {
//                        Text("Sender: \(giftData.gift.senderId)")
//                        Text("Email: \(curUser.email ?? "Error")")
//                        Text("Receiver: \(giftData.gift.receiverId ?? "DNE")")
//                    } else {
//                        Text("Receiver: \(giftData.gift.receiverId ?? "DNE")")
//                        Text("Email: \(curUser.email ?? "Error")")
//                        Text("Sender: \(giftData.gift.senderId)")
//                    }
//                    if let compl = giftData.getTodayCompliment(){
//                        Text("Todays Compliment: \(compl)")
//                    }
//                    
//                    var gd = giftData.getSentGifts()
//                    if  gd != [:] {
//                        Picker("Select a date", selection: $select) {
//                            ForEach(gd.keys.sorted(), id: \.self) { key in
//                                Text(key, style: .date).tag(key)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        if let vl = gd[select] {
//                            TextField("Value", text: Binding (
//                                get: {gd[select] ?? ""},
//                                set: {gd[select] = $0}
//                            ))
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                        }
//                    } else {
//                        Text("No Compliments Given")
//                    }
//                } else {
//                    Text("UserId: \(curUser.userId)")
//                    Text("Role: \(curUser.type ?? 10)")
//                }
//            } else { Text("No User Loaded")}
//            
//        }
        
        

                
    }
    
}

