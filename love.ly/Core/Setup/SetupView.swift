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
    @State private var navPath: [Int] = []
    var body: some View {
        NavigationStack(path: $navPath){
            VStack {
                Button("Get Started") {
                    navPath.append(1)
                }
                .onAppear {
                    Task {
                        do {
                            try await productSetupManager.loadProgress()
                        } catch {
                            print("couldnt load progress")
                        }
                        
                    }
                }
            }
            .navigationDestination(for: Int.self) { number in
                switch number {
                case 1: PersonalityPromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismiss)
                case 2: AppearencePromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismiss)
                case 3: InsecurityPromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismiss)
                case 4: HardshipPromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismiss)
                case 5: DreamsPromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismiss)
                case 6: SmallThingsPromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismiss)
                case 7: SongsPromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismiss)
                case 8: FuturePromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismiss)
                case 9: TalentsPromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismiss)
                case 10: OtherPromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismiss)
                case 11: SetupFinishView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismiss)
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
                            if try await productSetupManager.saveProgress() {
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

#Preview {
    SetupView(productSetupManager: .init())
}
