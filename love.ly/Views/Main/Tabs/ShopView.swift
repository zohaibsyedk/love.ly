//
//  ShopView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import SwiftUI
import StoreKit
internal import Combine
import FirebaseAuth

@MainActor
final class StoreViewModel: ObservableObject {
    private let productIdentifier: String = "com.lovely.app.gift"
        
    @Published var product: Product?
    @Published var isPurchased = false
        
    init(){
        Task{
            await loadProduct()
            listenForTransaction()
                
        }
    }
        
    func loadProduct() async {
        if let loaded = try? await Product.products(for: [productIdentifier]).first {
            product = loaded
        } else {
            print("not propagated")
        }
    }
        
    func purchase() async {
        guard let product = product else { return }
            
        if case .success(let result) = try? await product.purchase(),
            case .verified(let transaction) = result {
            await transaction.finish()
            print("Step 1 Solid")
        }
    }
        
        
    private func listenForTransaction()  {
        Task { for await update in Transaction.updates {
            print("in task")
            if case .verified(let transaction) = update, transaction.productID == productIdentifier {
                await transaction.finish()
                await MainActor.run {
                    self.isPurchased = true
                }
                print("Step 3 Solid")
            } else {
                print("bs")
            }
        }}
    }
        
}

struct ShopView: View {
    
    @EnvironmentObject var giftData: GiftData
    @StateObject private var store = StoreViewModel()
    @State private var productHolder: Bool = false
    @State private var productFinished: Bool = false
    @State private var productActive: Bool = false
    @State private var showSetupView: Bool = false
    @State private var onAppearRan: Bool = false
    @Binding var showSignInView: Bool
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
    
    var body: some View {
        List {
            if (curUser.productReceiving ?? false) == true {
                Text("Enjoy, someone thinks youre special.")
            } else {
                if curUser.productHolder == false {
                    if let product = store.product {
                        Text("Purchased: \(store.isPurchased ? "Yes" : "No")")
                        Button {
                            Task { await store.purchase()}
                            print(store.isPurchased)

                        } label: {
                            Text(store.isPurchased ? "Purchased" : "Buy \(product.displayPrice)")
                        }
                        .buttonStyle(ButtonWhiteStyle())
                        .disabled(store.isPurchased)
                    }
                    else {
                        Text("Not Propogated")
                    }
                } else {
                    if curUser.productFinished == false {
                        Button("Product Setup"){
                            showSetupView = true
                        }
                    } else {
                        if curUser.productActive == false {
                            Button("Copy Gift Link") {
                                let texts = "zohaibsyedk.github.io/gifts/\(curUser.userId)"
                                UIPasteboard.general.string = texts
                            }
                        } else {
                            Text("View Progress")
                        }
                    }
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
                    try await updateCondensed(view: "ShopView", place:  "onAppear")
                }
            }
            onAppearRan = true
        }

        .fullScreenCover(isPresented: $showSetupView) {
            NavigationStack {
                SetupView(curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser)
            }
        }
        .onChange(of: store.isPurchased) { (isPurchased) in
                onAppearRan = false
        }
    }
}

