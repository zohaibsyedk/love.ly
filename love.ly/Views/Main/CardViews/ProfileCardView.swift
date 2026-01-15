//
//  ProfileCardView.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/13/26.
//

import SwiftUI
internal import Combine
import FirebaseAuth

struct ProfileCardView: View {
    
    @EnvironmentObject var giftData: GiftData
    @Binding var curUser: DBUser
    @Binding var curGift: ProductItem
    @Binding var update: Bool
    @Binding var activeTab: AppTab
    
    var body: some View {
        if curUser.type == 1 {
            ScrollView {
                CardOneView()
                CardOne2View()
            }
        }
        else {
            Text("ID: \(curUser.userId)")
            Text("Type: \(String(curUser.type ?? 10))")
        }
    }
}



//#Preview {
//    ProfileCardView()
//}
