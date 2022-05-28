import SwiftUI

struct PagePlaygroundView: View {
    
    /// manage user progress
    @ObservedObject private var appState: AppState
    
    @State private var showingHelpPopover = false
    
    var currentPage: Page {
        BasicsCourse[appState.currentPage]
    }
    
    public init(appState: AppState) {
        self.appState = appState
    }
    
    var body: some View {
        
        let playgroundViewtoDraw = BasicsCourse[appState.currentPage].playgroundView
        VStack{
            switch playgroundViewtoDraw {
            case .welcomePlaygroundView:
                WelcomePlaygroundView(appState: appState)
            case .fontsPlaygroundView:
                FontsPlaygroundView(appState: appState)
            case .hierarchyPlaygroundView:
                HierarchyPlaygroundView(appState: appState)
            case .spacingPlaygroundView:
                SpacingPlaygroundView(appState: appState)
                    .overlay { Text("Work in progress").font(.title).bold().foregroundColor(.red).rotationEffect(Angle(degrees: -45)) }
            case .alignmentPlaygroundView:
                AlignmentPlaygroundView(appState: appState)
            case .kerningPlaygroundView:
                KerningPlaygroundView(appState: appState)
            case .quizPlaygroundView:
                QuizPlaygroundView(appState: appState)
            }
            
        }
        .popover(isPresented: $showingHelpPopover) {
            helpPopover
                .frame(width: 330)
                .frame(maxHeight: 439)
        }
        .padding(30)
        .padding(.top, 15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(currentPage.challengeHelp != nil ? helpOverlay.opacity(1.0) : helpOverlay.opacity(0.0), alignment: .top)
        
    }
    
    
    
    
    private var helpOverlay: some View {
        VStack{
            HStack{
                Spacer()
                Button {
                    showingHelpPopover.toggle()
                } label: {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.accentColor)
                }
            }
            Spacer()
        }
        .padding(.top, 48)
        .padding(.trailing, 15)
    }
    
    private var helpPopover: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Challenge help")
                    .font(.headline)
                Spacer()
                InteractableView(basePadding: 7, sidePadding: 5){
                    Button {
                        showingHelpPopover.toggle()
                    } label: {
                        Text("Dismiss")
                            .font(.footnote)
                    }
                }
                
            }
            ScrollView{
                Text(currentPage.challengeHelp ?? "No help available")
                    .font(.callout)
                    .lineSpacing(1.2)
            }
            .padding(.top, 10)
        }
        .padding(20)
    }
}
