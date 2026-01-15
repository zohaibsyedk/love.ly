//
//  SetupView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import SwiftUI
internal import Combine



struct ComplimentAddView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @Binding var navPath: [Int]
    @Binding var curUser: DBUser
    @Binding var curGift: ProductItem
    @Binding var update: Bool
    @Binding var complimentcount: Int
    @Binding var authUser: AuthDataResultModel?
    @State var complimentText: String = ""
    let dismissFullScreen: DismissAction
    let ind: Int = 1
    var body: some View {
        VStack {
            Text("Let there be light!")
            TextField("Enter Compliment Here", text: $complimentText)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                curGift.addComplimentsStore(compliment: complimentText)
                complimentcount += 1
                complimentText = ""
            } label: {
                Text("Add Compliment")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxHeight:55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(complimentText.trimmingCharacters(in: .whitespaces).isEmpty)
            
            Button {
                navPath.append(ind + 1)
            } label: {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxHeight:55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Text("Current Compliments:")
            List {
                ForEach(curGift.complimentsStore, id: \.self) { item in
                    Text(item)
                }
                .onDelete {indexSet in
                    curGift.complimentsStore.remove(atOffsets: indexSet)
                    complimentcount -= 1
                    
                }
            }
        
            
            Spacer()
            Text("Total Compliments: \(complimentcount)")
        }
        .onAppear {
            complimentcount = curGift.complimentsStore.count
        }

        .navigationTitle("Product Setup")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save & Exit") {
                    Task {
                        do {
                            if try await productSetupManager.saveProgress(uid: authUser?.uid ?? "none", cstore: curGift.complimentsStore) {
                                print("Success")
                                update = true
                            } else {
                                print("Fail")
                            }
                        } catch {
                            print("Error: ", error)
                        }
                        
                    }
                    navPath.removeAll()
                    dismissFullScreen()
                }
            }
        }

    }
    
}

