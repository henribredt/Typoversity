//
//  AlignmentPlaygroundView.swift
//  TypographyCourse
//
//  Created by Henri Bredt on 29.04.22.
//

import SwiftUI

struct AlignmentPlaygroundView: View {
    
    // manage user progress
    @ObservedObject var appState: AppState
    
    // Title
    @State var titleAlignment : TextAlignment = .center
    @State var titleSelection = 0
    @State var titleCorrect = false
    @State var titleAreaAnimationValue = false
    
    // Left paragraph
    @State var leftParagraphAlignment : TextAlignment = .trailing
    @State var leftParagraphSelection = 2
    @State var leftParagraphCorrect = false
    @State var leftParagraphAreaAnimationValue = false
    
    // Right paragraph
    @State var rightParagraphAlignment : TextAlignment = .trailing
    @State var rightParagraphSelection = 2
    @State var rightParagraphCorrect = false
    @State var rightParagraphAreaAnimationValue = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Spacer()
            ScrollView{
                VStack(alignment: .leading, spacing: 10){
                    Text("An example news paper article with two colums of placeholer text")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .highlightable(padding: 6, animationValue: $titleAreaAnimationValue)
                        .padding(.bottom, 10)
                        .multilineTextAlignment(titleAlignment)
                    HStack(alignment: .top, spacing: 16){
                        Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
                            .lineSpacing(1.5)
                            .font(.caption)
                            .multilineTextAlignment(leftParagraphAlignment)
                            .highlightable(padding: 6, animationValue: $leftParagraphAreaAnimationValue)
                        Text("Sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
                            .lineSpacing(1.5)
                            .font(.caption)
                            .multilineTextAlignment(rightParagraphAlignment)
                            .highlightable(padding: 6, animationValue: $rightParagraphAreaAnimationValue)
                    }
                }
                
                .padding()
            }
            Spacer()
            Spacer()
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    AlignmentSelector(selection: $titleSelection, correct: $titleCorrect, animationValue: $titleAreaAnimationValue, title: "Title")
                    AlignmentSelector(selection: $leftParagraphSelection, correct: $leftParagraphCorrect, animationValue: $leftParagraphAreaAnimationValue, title: "Left")
                    AlignmentSelector(selection: $rightParagraphSelection, correct: $rightParagraphCorrect, animationValue: $rightParagraphAreaAnimationValue, title: "Right")
                }
                .onChange(of: titleSelection) { newValue in
                    titleAlignment = updateAlignment(tag: newValue)
                    if titleSelection == 1 { titleCorrect = true } else { titleCorrect = false }
                    checkChallengeCompleted()
                }
                .onChange(of: leftParagraphSelection) { newValue in
                    leftParagraphAlignment = updateAlignment(tag: newValue)
                    if leftParagraphSelection == 1 { leftParagraphCorrect = true } else { leftParagraphCorrect = false }
                    checkChallengeCompleted()
                }
                .onChange(of: rightParagraphSelection) { newValue in
                   rightParagraphAlignment = updateAlignment(tag: newValue)
                    if rightParagraphSelection == 1 { rightParagraphCorrect = true } else { rightParagraphCorrect = false }
                    checkChallengeCompleted()
                }
            }
        }
        
    }
    
    struct Stack<Content>: View where Content: View {
        var views: Content
        var vertical: Bool
        var spacing: CGFloat
        
        init(verticalStack: Bool, spacing : CGFloat = 0, @ViewBuilder content: () -> Content) {
            self.views = content()
            self.vertical = verticalStack
            self.spacing = spacing
        }
        
        var body: some View {
            if vertical {
                VStack(alignment: .leading, spacing: spacing){
                    views
                }
            } else {
                HStack(alignment: .top, spacing: spacing){
                    views
                }
            }
        }
    }
    
    func updateAlignment(tag: Int) -> TextAlignment {
           switch tag {
           case 0: // centered
               return .center
           case 1: // left align
               return .leading
           case 2: // right align
               return .trailing
           default:
               return .leading
           }
    }
    
    func checkChallengeCompleted(){
        if (titleCorrect && leftParagraphCorrect && rightParagraphCorrect) {
            /// currently opend page
            let currentPage = BasicsCourse[appState.currentPage]
            // Mark lesson as completed
            appState.appendToCompletionProgress(id: currentPage.id)
        }
    }
}



struct AlignmentSelector: View {
    
    @Binding var selection: Int
    @Binding var correct: Bool
    @Binding var animationValue: Bool
    var title: String
    
    var body: some View {
        HStack(spacing: 30){
            HStack(alignment: .center) {
                // Icon
                if (correct) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.green)
                        .frame(width: 20, height: 20)
                        .padding(5)
                        .padding(.trailing, 4)
                        .transition(.scale.combined(with: .opacity))
                } else {
                    Image(systemName: "paragraphsign")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.accentColor)
                        .frame(width: 18, height: 18)
                        .padding(5)
                        .padding(.trailing, 4)
                        .transition(.scale.combined(with: .opacity))
                }
                HStack{
                    Text(title)
                        .font(.callout)
                        .onTapGesture {
                            animationValue = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
                                animationValue = false
                            })
                        }
                    Spacer()
                }
                .frame(width: 64)
            }
            .animation(Animation.timingCurve(0.44, 1.86, 0.61, 0.99, duration: 0.6), value: correct)
            
            InteractableView(basePadding: 7, sidePadding: 7) {
                HStack(spacing: 0) {
                    Image(systemName: "chevron.down")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.accentColor)
                        .padding(.trailing, 12)
                    Picker(title, selection: $selection, content: {
                        Text("Right aligned").tag(2)
                        Text("Left aligned").tag(1)
                        Text("Centered").tag(0)
                    })
                    .onTapGesture {
                        animationValue = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
                            animationValue = false
                        })
                    }
                    Spacer()
                }
            }
        }
    }
}
