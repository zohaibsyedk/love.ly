//
//  SetupView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import SwiftUI
internal import Combine
import FirebaseAuth



struct SetupFinishView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @Binding var navPath: [Int]
    @Binding var curUser: DBUser
    @Binding var curGift: ProductItem
    @Binding var update: Bool
    @Binding var complimentcount: Int
    @Binding var authUser: AuthDataResultModel?
    //@Binding var loaded: Bool
    let dismissFullScreen: DismissAction
    var body: some View {
        VStack {
            Text("Confirm Selected Compliments")
            Button("Complete Product Setup") {
                Task {
                    do {
                        guard let usr = authUser else {
                            throw NSError(domain: "setup finish", code: 1, userInfo: [NSLocalizedDescriptionKey: "no Auth"])
                        }
                        let userId = usr.uid
                        let texts = "zohaibsyedk.github.io/gifts/\(userId)"
                        curGift.storeToCompliments()
                        let finalized = try await productSetupManager.finalizeSetup(num: complimentcount, uid: userId, gift: curGift)
                        UIPasteboard.general.string = texts
                        if finalized {
                            //loaded = try await rootModel.updateUser(use: "setup finish view refresh")
                            print("Success finalized")
                            update = true
                        } else {
                            print("finalization failed")
                        }
                        navPath.removeAll()
                        dismissFullScreen()
                    } catch {
                        // Handle error as appropriate, or ignore
                        print("Failed to setup product: \(error)")
                    }
                    }
                }

            .pickerStyle(.menu)
            List {
                ForEach(curGift.complimentsStore, id: \.self) { item in
                    Text(item)
                }
                .onDelete {indexSet in
                    curGift.complimentsStore.remove(atOffsets: indexSet)
                    complimentcount -= 1
                    
                }
            }
    
        }

    }
    
}


