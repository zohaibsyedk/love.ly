////
////  StoreViewModel 2.swift
////  love.ly
////
////  Created by Zohaib Syed on 1/15/26.
////
//
//import SwiftUI
//import StoreKit
//internal import Combine
//import FirebaseAuth
//
//@MainActor
//    final class StoreViewModel: ObservableObject {
//        private let productIdentifier: String = "com.lovely.app.gift"
//        
//        @Published var product: Product?
//        @Published var isPurchased: Bool = false
//        
//        init(){
//            Task{
//                await loadProduct()
//                await updatePurchaseStatus()
//                
//            }
//        }
//        
//        func loadProduct() async {
//            if let loaded = try? await Product.products(for: [productIdentifier]).first {
//                product = loaded
//            }
//        }
//        
//        func purchase() async {
//            guard let product = product else { return }
//            
//            if case.success(let result) = try? await product.purchase(),
//               case.verified(let transaction) = result {
//                await transaction.finish()
//                await updatePurchaseStatus()
//            }
//        }
//        
//        func updatePurchaseStatus() async {
//            if let result = await Transaction.latest(for: productIdentifier),
//               case.verified(let transaction) = result {
//                isPurchased = (transaction.revocationDate == nil)
//                print(isPurchased)
//            } else {
//                isPurchased = false
//            }
//        }
//        
//        private func listenForTransaction() {
//            Task {for await update in Transaction.updates {
//                if case.verified(let transaction) = update, transaction.productID == productIdentifier {
//                    await transaction.finish()
//                    await updatePurchaseStatus()
//                }
//            }}
//        }
//        
//    }
