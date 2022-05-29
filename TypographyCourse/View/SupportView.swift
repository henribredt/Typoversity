//
//  SupportView.swift
//  TypographyCourse
//
//  Created by Henri Bredt on 28.05.22.
//

import SwiftUI
import StoreKit
import MessageUI

struct SupportView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var showShareSheet = false
    
    @StateObject var store: Store = Store()
    
    @State var errorTitle = ""
    @State var isShowingError: Bool = false
    @State var isShowingThanksView = false
    
    var body: some View {
        
        VStack(spacing: 0){
            
            header
            
            ScrollView(showsIndicators: false){
                VStack(alignment: .center, spacing: 16){
                    
                    rateSendShare
                    
                    HStack(spacing: 16){
                        // Create all buttons based on the products loaded from AppStore in Store.swift
                        ForEach(store.products, id: \.id) { tip in
                            
                            AsyncSupportButton(color: .green, text: "Tip \(tip.displayPrice)") {
                                // buy logic
                                do {
                                    if try await store.purchase(tip) != nil {
                                        isShowingThanksView = true
                                    }
                                } catch Store.StoreError.failedVerification {
                                    errorTitle = "Your purchase could not be verified by the App Store."
                                    isShowingError = true
                                } catch {
                                    print("Failed purchase for \(tip.id): \(error)")
                                    errorTitle = error.localizedDescription
                                    isShowingError = true
                                }
                            }
                    
                        }
                        
                        // Show while no products loaded
                        if store.products.isEmpty {
                            HStack(spacing: 12){
                                ProgressView()
                                Text("Loading donation options, please connect to network")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                    }
                    Text("Thank you for your support \u{00a0}❤️")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.top, 15)
                    
                }
                .frame(maxWidth: 450)
                
            }
            
            Spacer()
            Button {
                dismiss()
            } label: {
                InteractableView(basePadding: 12, sidePadding: 7) {  Text("Dismiss").font(.callout) }
            }
            .padding()
            
        }
        .padding(EdgeInsets(top: 60, leading: 60, bottom: 30, trailing: 60))
        ///MARK: ShareSheet
        .sheet(isPresented: $showShareSheet, content: { ActivityViewController(itemsToShare: ["Check out Typoversity on the AppStore https://itunes.apple.com/app/apple-store/id1620952845?mt=8"]) })
        .sheet(isPresented: $isShowingThanksView, content: { ThanksView()})
        ///MARK: Store Error Alert
        .alert(isPresented: $isShowingError, content: {
            Alert(title: Text(errorTitle), message: nil, dismissButton: .default(Text("Okay")))
        })
    }
    
    
    var header: some View {
        VStack(spacing: 0){
            HStack{
                Spacer()
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(
                        Color.accentColor
                            .cornerRadius(15)
                    )
                Spacer()
            }
            
            VStack(spacing: 6){
                
                Text("Send some love")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 7)
                    .multilineTextAlignment(.center)
                
                Text("Support this app")
                    .font(.title2).fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            .padding(.top)
            .padding(.bottom)
            .padding(.bottom, 52)
            
        }
    }
    
    var rateSendShare: some View {
        VStack(spacing: 16) {
            SupportButton(text: "Rate on the App Store") {
                if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "1620952845" + "?mt=8&action=write-review") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            SupportButton(text: "Send feedback"){
                let email = "hello@henribredt.de"
                if let url = URL(string: "mailto:\(email)") {
                    UIApplication.shared.open(url)
                }
                
                func getOSInfo() -> String {
                    let processInfo = ProcessInfo().operatingSystemVersion
                    return "\(processInfo.majorVersion).\(processInfo.minorVersion).\(processInfo.patchVersion)"
                }
            }
            SupportButton(text: "Share app") {
                showShareSheet = true
            }
            Rectangle()
                .frame(height: 3)
                .cornerRadius(3)
                .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
        }
    }
}


struct SupportButton: View {
    var color: Color = .accentColor
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            InteractableView(color: color, basePadding: 15, sidePadding: 7) {
                Text(text)
                    .foregroundColor(color)
                    .font(.callout)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct AsyncSupportButton: View {
    var color: Color = .accentColor
    var text: String
    var action: () async -> Void
    
    var body: some View {
        Button {
            Task {
                await action()
            }
        } label: {
            InteractableView(color: color, basePadding: 15, sidePadding: 7) {
                Text(text)
                    .foregroundColor(color)
                    .font(.callout)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
