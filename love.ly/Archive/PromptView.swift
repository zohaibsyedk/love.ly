////
////  SetupView.swift
////  love.ly
////
////  Created by Zohaib Syed on 12/21/25.
////
//
//import SwiftUI
//internal import Combine
//
//
//
//struct PromptView: View {
//    @Environment(\.dismiss) private var dismiss
//    @ObservedObject var productSetupManager: ProductSetupManager
//    @State var count : Int = 0
//    @Binding var navPath: [Int]
//    let dismissFullScreen: DismissAction
//    let prompt: String
//    let ind: Int
//    var body: some View {
//        VStack {
//            Text(prompt.capitalized)
//            TextField("type a compliment", text: $productSetupManager.current)
//                .padding()
//                .background(Color.gray.opacity(0.4))
//                .cornerRadius(10)
//            
//            Button {
//                productSetupManager.addComplimentsStage()
//                productSetupManager.counts += 1
//            } label: {
//                Text("Add Compliment")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(maxHeight:55)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            .disabled(productSetupManager.current.trimmingCharacters(in: .whitespaces).isEmpty)
//            
//            Button {
//                navPath.append(ind + 1)
//            } label: {
//                Text("Continue")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(maxHeight:55)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            Text("Compliments selected for \(prompt): \(productSetupManager.complimentsStore.count)")
//            List {
//                ForEach(productSetupManager.complimentsStore, id: \.self) { item in
//                    Text(item)
//                }
//                .onDelete {indexSet in
//                    productSetupManager.complimentsStore.remove(atOffsets: indexSet)
//                    productSetupManager.counts -= 1
//                    
//                }
//            }
//        
//            
//            Spacer()
//            Text("Compliments to Stage: \(productSetupManager.counts)")
//        }
////        .onAppear{
////            Task {
////                do {
////                    try await productSetupManager.loadProgress()
////                } catch {print("Failed to load: ", error)}
////            }
////        }
//        .navigationTitle("Product Setup")
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                Button("Save & Exit") {
//                    Task {
//                        do {
//                            if try await productSetupManager.saveProgress() {
//                                print("Success")
//                            } else {
//                                print("Fail")
//                            }
//                        } catch {
//                            print("Error: ", error)
//                        }
//                        
//                    }
//                    navPath.removeAll()
//                    dismissFullScreen()
//                }
//            }
//        }
//
//    }
//    
//}
//
