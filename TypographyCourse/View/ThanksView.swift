//
//  ThanksView.swift
//  TypographyCourse
//
//  Created by Henri Bredt on 29.05.22.
//

import SwiftUI
import ConfettiSwiftUI

struct ThanksView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var counter: Int = 0
    
    var body: some View {
        
        VStack(spacing: 0){
            
            Spacer()
            
            VStack(spacing: 0){
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                
                Text("Thank you for your support")
                    .font(.largeTitle).bold()
                    .padding(.top, 30)
                
                Text("You've succesfully tipped me")
                    .padding(.top, 15)
                    .confettiCannon(counter: $counter, num: 25,  confettis: [.text("💙"), .text("❤️")],  confettiSize: 18)
            }
            .onTapGesture {
                counter += 1
            }
            
            Spacer()
            Spacer()
            
            Button {
                dismiss()
            } label: {
                InteractableView(basePadding: 12, sidePadding: 7) {  Text("Dismiss").font(.callout) }
            }
            .padding()
            
        }
        .padding(60)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                counter += 1
            }
        }
    }
    
}
