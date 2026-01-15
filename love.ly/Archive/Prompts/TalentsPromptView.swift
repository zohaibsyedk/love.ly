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
//struct TalentsPromptView2: View {
//    @Environment(\.dismiss) private var dismiss
//    @ObservedObject var productSetupManager: ProductSetupManager
//    @State var count : Int = 0
//    @Binding var navPath: [Int]
//    let prompt = "talents"
//    let dismissFullScreen: DismissAction
//    var body: some View {
//        VStack {
//            Text("Talents")
//            TextField("type a compliment", text: $productSetupManager.current)
//                .padding()
//                .background(Color.gray.opacity(0.4))
//                .cornerRadius(10)
//            
//            Button {
//                productSetupManager.addComplimentsStage()
//                productSetupManager.counts += 1
//            } label: {
//                Text("Add Affirmation")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(maxHeight:55)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            .disabled(productSetupManager.current.trimmingCharacters(in: .whitespaces).isEmpty)
//            
//            Button("Continue") {
//                navPath.append(10)
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
//        .navigationTitle("Title")
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
