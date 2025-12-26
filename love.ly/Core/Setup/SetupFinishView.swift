//
//  SetupView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import SwiftUI
internal import Combine



struct SetupFinishView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @State var count : Int = 0
    @Binding var navPath: [Int]
    let dismissFullScreen: DismissAction
    let prompts = ["personality", "appearence", "insecurity", "hardship", "dreams", "smallthings", "songs", "future", "talents"]
    @State private var selected = "personality"
    var body: some View {
        VStack {
            Text("Confirm Selected Compliments")
            Button("Comlete Product Setup") {
                Task {
                    do {
                        let finalized = try await productSetupManager.finalizeSetup()
                        if finalized {
                            print("Success finalized")
                        } else {
                            print("finalization failed")
                        }
                        navPath.removeAll()
                        dismissFullScreen()
                    } catch {
                        // Handle error as appropriate, or ignore
                        print("Failed to buy product: \(error)")
                    }
                    }
                }
            Picker("Select Category", selection: $selected) {
                ForEach(prompts, id: \.self) { option in
                    Text(option)
                }
            }
            .pickerStyle(.menu)
            List {
                ForEach(productSetupManager.complimentsStore[selected] ?? [], id: \.self) { item in
                    Text(item)
                }
                .onDelete {indexSet in
                    productSetupManager.complimentsStore[selected]?.remove(atOffsets: indexSet)
                    productSetupManager.counts -= 1
                    
                }
            }
    
        }

    }
    
}


