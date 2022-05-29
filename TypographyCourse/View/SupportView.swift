//
//  SupportView.swift
//  TypographyCourse
//
//  Created by Henri Bredt on 28.05.22.
//

import SwiftUI
import StoreKit

//
//class StoreViewModel: ObservedObject {
//    func fetchProducts() {
//        async {
//            do {
//            let products = try await Product.request(with: ["de.henribredt.Typoversity"])
//            } catch {
//                print(error)
//            }
//        }
//    }
//}


struct SupportView: View {
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
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
                
                Text("Share some love")
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
            
            
            ScrollView(showsIndicators: false){
                VStack(alignment: .center, spacing: 16){
                    SupportButton(text: "Rate on the App Store", action: { return })
                    SupportButton(text: "Send feedback", action: { return })
                    SupportButton(text: "Share app", action: { return })
                    Rectangle()
                        .frame(height: 3)
                        .cornerRadius(3)
                        .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
                    HStack(spacing: 16){
                        SupportButton(color: .green, text: "Tip 0,99€", action: { return })
                        SupportButton(color: .green, text: "Tip 1,99€", action: { return })
                        SupportButton(color: .green, text: "Tip 4,99€", action: { return })
                    }
                    Text("Thank you for your support \u{00a0}❤️")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.top, 15)
                    Button {
                        print("restore")
                    } label: {
                        Text("Restore")
                            .font(.footnote)
                    }
                    .padding(.top, -10)

            
                    
                }
                .frame(maxWidth: 480)
                
                
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


