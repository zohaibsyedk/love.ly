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
    @State var count : Int = 0
    var body: some View {
        NavigationStack{
            VStack {
                TextField("type a compliment", text: $productSetupManager.current)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                
                Button {
                    productSetupManager.addComplimentsStage()
                    productSetupManager.counts += 1
                } label: {
                    Text("Add Compliment")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxHeight:55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(productSetupManager.current.trimmingCharacters(in: .whitespaces).isEmpty || productSetupManager.counts >= 10)
                
                Button {
                    Task {
                        if try await productSetupManager.finalizeSetup(){
                            dismiss()
                        }
                    }
                    
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxHeight:55)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .disabled(productSetupManager.counts < 10)
            
                
                Spacer()
                Text("Compliments to Stage: \(productSetupManager.counts)")
            }
        }
        .onAppear{
            Task {
                do {
                    try await productSetupManager.loadProgress()
                } catch {print("Failed to load: ", error)}
            }
        }
        .navigationTitle("Title")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save & Exit") {
                    Task {
                        do {
                            if try await productSetupManager.saveProgress() {
                                print("Success")
                            } else {
                                print("Fail")
                            }
                        } catch {
                            print("Error: ", error)
                        }
                        
                    }
                    dismiss()
                }
            }
        }

    }
    
}

#Preview {
    SetupView()
}
