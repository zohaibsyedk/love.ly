//
//  SetupView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import SwiftUI
internal import Combine

struct SetupView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var productSetupManager = ProductSetupManager()
    @State private var navPath: [Int] = []
    @Binding var curUser: DBUser
    @Binding var curGift: ProductItem
    @Binding var update: Bool
    @Binding var authUser: AuthDataResultModel?
    @State var complimentcount = 0
    //@Binding var loaded: Bool
    var body: some View {
        NavigationStack(path: $navPath){
            VStack {
                Button("Get Started") {
                    navPath.append(1)
                }
                .onAppear {
                    Task { @MainActor in
                        do {
                            //try await productSetupManager.loadProgress()
                            curUser = try await RootModel.shared.updateUser(ath: authUser)
                            curGift = try await RootModel.shared.updateGift(user: curUser)
                            curUser.initialize(gift: curGift)
                        } catch {
                            print("couldnt load progress")
                        }
                        
                    }
                }
            }
            .navigationDestination(for: Int.self) { number in
                switch number {
                case 1: ComplimentAddView(productSetupManager: productSetupManager, navPath: $navPath, curUser: $curUser, curGift: $curGift, update: $update, complimentcount: $complimentcount, authUser: $authUser, dismissFullScreen: dismiss)
                case 2: SetupFinishView(productSetupManager: productSetupManager, navPath: $navPath, curUser: $curUser, curGift: $curGift, update: $update, complimentcount: $complimentcount, authUser: $authUser, dismissFullScreen: dismiss)
                default: Text("Unknown Prompt")
                }
                
            }
        }
        .navigationTitle("Title")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save & Exit") {
                    Task {
                        do {
                            if try await productSetupManager.saveProgress(uid: authUser?.uid ?? "none", cstore: curGift.complimentsStore) {
                                update = true
                                print("Success")
                            } else {
                                print("Fail")
                            }
                        } catch {
                            print("Error: ", error)
                        }
                        
                    }
                    navPath.removeAll()
                    dismiss()
                }
            }
        }

    }
    
}
