import ConfettiSwiftUI
import SwiftUI

struct WelcomePlaygroundView: View {
    
    // manage user progress
    @ObservedObject var appState: AppState
    
    // animation values
    @State private var cofettiAnimationValue: Int = 0
    
    /// currently opend page
    var currentPage : Page {
        BasicsCourse[appState.currentPage]
    }
    
    var body: some View {
        VStack{
            Spacer()
            Image(systemName: "character.cursor.ibeam")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(Color.accentColor.opacity(0.3))
                .padding(.bottom, 50)
            HStack{
                Spacer()
                Text("This is the playground view where you will be soving the callenges.")
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                Spacer()
            }
            
            HStack{
                if !appState.completionProgress.contains(currentPage.id) {
                    Button {
                        /// currently opend page
                        let currentPage = BasicsCourse[appState.currentPage]
                        // Mark lesson as completed
                        appState.appendToCompletionProgress(id: currentPage.id)
                        cofettiAnimationValue += 1
                    } label: {
                        InteractableView(basePadding: 12, sidePadding: 8) { Text("Got it") }
                            .transition(.scale.combined(with: .opacity))
                            .padding(2.5)
                    }
                    
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.green)
                        .frame(width: 40, height: 40)
                        .padding(5)
                        .padding(.trailing, 4)
                        .transition(.scale.combined(with: .opacity))
                        .onTapGesture {
                            cofettiAnimationValue += 1
                        }
                }
            }
            .animation(Animation.timingCurve(0.44, 1.86, 0.61, 0.99, duration: 0.5), value: appState.completionProgress)
            .confettiCannon(counter: $cofettiAnimationValue)
            Spacer()
        }
        .animation(Animation.timingCurve(0.16, 0.9, 0.51, 1, duration: 0.3), value: appState.completionProgress)
    }
}

