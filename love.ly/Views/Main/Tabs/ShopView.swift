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
import Foundation

@MainActor
class IAPManager: ObservableObject {
    static let shared = IAPManager()
    
    @Published var products: [Product] = []
    @Published var purchasedProducts: [Product] = []
    @Published var purchaseError: Error?
    
    private init() {
        Task {
            await loadProducts()
            await updatePurchasedProducts()
        }
    }
    
    // MARK: - Load Products
    func loadProducts() async {
        do {
            let productIds = ["com.lovely.app.gift"]
            
            // Attempt real App Store fetch
            var fetchedProducts = try await Product.products(for: productIds)
            
            if fetchedProducts.isEmpty {
                // Fallback: use StoreKit Configuration in Xcode (local testing)
                print("⚠️ No products from App Store. Using local StoreKit config for testing.")
                fetchedProducts = try await Product.products(for: productIds) // still works if local config exists
            }
            
            self.products = fetchedProducts
            print("✅ Loaded products:", fetchedProducts.map { $0.id })
        } catch {
            print("❌ Failed to fetch products:", error)
        }
    }
    
    // MARK: - Purchase Product
    func purchase(_ product: Product) async -> Bool {
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                
                // For consumables, finish transaction immediately
                await transaction.finish()
                
                await updatePurchasedProducts()
                print("✅ Purchase successful:", transaction.productID)
                return true
                
            case .userCancelled:
                print("⚠️ User cancelled purchase")
                return false
            case .pending:
                print("⏳ Purchase pending")
                return false
            @unknown default:
                print("❌ Unknown purchase result")
                return false
            }
        } catch {
            purchaseError = error
            print("❌ Purchase failed:", error)
            return false
        }
    }
    
    // MARK: - Verify Transaction
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified(_, let error):
            throw error
        case .verified(let safe):
            return safe
        }
    }
    
    // MARK: - Update Purchased Products
    func updatePurchasedProducts() async {
        do {
            var purchased: [Product] = []
            for await result in Transaction.currentEntitlements {
                if case .verified(let transaction) = result {
                    if let product = products.first(where: { $0.id == transaction.productID }) {
                        purchased.append(product)
                    }
                }
            }
            purchasedProducts = purchased
            print(purchasedProducts)
        } catch {
            print("❌ Failed to update purchased products:", error)
        }
    }
    
    // MARK: - Get product by ID
    func product(for id: String) -> Product? {
        return products.first(where: { $0.id == id })
    }
}



struct ShopView: View {
    
    @EnvironmentObject var giftData: GiftData
    @StateObject private var iap = IAPManager.shared
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
            if productHolder == false {
                if let gift = iap.product(for: "com.lovely.app.gift") {
                                Button("Buy Gift") {
                                    Task {
                                        self.productHolder = await iap.purchase(gift)
                                    }
                                }
                            } else {
                                Text("Loading products...")
                            }
                            
                            if !iap.purchasedProducts.isEmpty {
                                Text("Purchased: \(iap.purchasedProducts.map { $0.displayName }.joined(separator: ", "))")
                            }
                            
                            if let error = iap.purchaseError {
                                Text("Error: \(error.localizedDescription)")
                                    .foregroundColor(.red)
                            }
            } else {
                Text("BAUGHT")
            }
//            if (curUser.productReceiving ?? false) == true {
//                Text("Enjoy, someone thinks youre special.")
//            } else {
//                if curUser.productHolder == false {
//                    if let gift = store.product(for: "com.lovely.app.gift") {
//                        Text("Purchased: \(store.purchasedProducts.isEmpty ? "NO" : "YES")")
//                        Button {
//                            Task { await store.purchase(gift)}
//                            print(store.purchasedProducts.isEmpty ? "Fail" : "Success")
//
//                        } label: {
//                            Text(store.purchasedProducts.isEmpty ? "Buy $15" : "Purchased")
//                        }
//                        .buttonStyle(ButtonWhiteStyle())
//                        .disabled(!store.purchasedProducts.isEmpty)
//                    }
//                    else {
//                        Text("Loading")
//                    }
//                    if let error = store.purchaseError {
//                        Text("Error: \(error.localizedDescription)")
//                            .foregroundColor(.red)
//                    }
//                } else {
//                    if curUser.productFinished == false {
//                        Button("Product Setup"){
//                            showSetupView = true
//                        }
//                    } else {
//                        if curUser.productActive == false {
//                            Button("Copy Gift Link") {
//                                let texts = "zohaibsyedk.github.io/gifts/\(curUser.userId)"
//                                UIPasteboard.general.string = texts
//                            }
//                        } else {
//                            Text("View Progress")
//                        }
//                    }
//                }
//            }
            
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
//        .onChange(of: store.purchasedProducts) { (isPurchased) in
//                onAppearRan = false
//        }
    }
}

