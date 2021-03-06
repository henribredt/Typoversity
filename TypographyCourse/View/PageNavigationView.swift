import SwiftUI

struct PageNavigationView: View {
    
    public init(appState: AppState) { self.appState = appState }
    
    @Environment(\.colorScheme) private var colorScheme
    
    /// manage user progress
    @ObservedObject private var appState: AppState
    
    var body : some View {
        VStack(alignment: .leading, spacing: 0){
            
            courseInfoHeader
            
            Text("Lessons")
                .font(.caption).fontWeight(.medium)
                .padding(.bottom, 10)
            
            pageOverview
            
            VStack(spacing: 8){
                moreButton
                supportButton
            }
        }
        .padding(18)
        .padding(.top, 25)
        .background(Color(uiColor: .secondarySystemBackground))
        .animation(Animation.timingCurve(0.44, 1.86, 0.61, 0.99, duration: 0.5), value: appState.completionProgress)
        .sheet(isPresented: $appState.showingAboutView){
            AboutView()
        }
        .sheet(isPresented: $appState.showingSupportView){
            SupportView()
        }
    }
    
    
    //  MARK: courseInfoHeader
    /// contines course title and a progress bar
    var courseInfoHeader : some View {
        VStack(alignment: .leading, spacing: 4){
            Text("Typography")
                .font(.footnote)
            Text("Basics Crashcourse")
                .font(.title3).fontWeight(.semibold)
                .padding(.bottom, 20)
            ProgressView(value: Float(appState.completionProgress.count), total: Float(BasicsCourse.count))
            HStack{
                Text("\((appState.completionProgress.count) * 100 / BasicsCourse.count) % completed")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Button {
                    appState.resetCompletionProgress()
                } label: {
                    Text("Reset progess")
                        .font(.caption)
                        .foregroundColor(.accentColor)
                }
                
            }
            .padding(.top, 2)
            .padding(.bottom, 60)
        }
    }
    
    //  MARK: pageOverview
    /// shows all availabe pages in a course including its completion status and allows navigation
    
   
    var pageOverview: some View {
        VStack(alignment: .leading){
            ScrollView{
                VStack(spacing: 0){
                    ForEach(BasicsCourse, id: \.self.id) { page in
                        Button {
                            let index = BasicsCourse.firstIndex(of: page) ?? 0
                            appState.currentPage = index
                        } label: {
                            HStack{
                                if (appState.completionProgress.contains(page.id)) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color.green)
                                        .frame(width: 20, height: 20)
                                        .padding(5)
                                        .padding(.trailing, 4)
                                        .transition(.scale.combined(with: .opacity))
                                } else {
                                    Image(systemName: page.titleImageName)
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color.accentColor)
                                        .frame(width: 20 + page.titleImageSizeAdjustment, height: 20 + page.titleImageSizeAdjustment)
                                        .padding(5)
                                        .padding(.trailing, 4)
                                        .transition(.scale.combined(with: .opacity))
                                }
                                Text(page.title)
                                    .font(.callout)
                                    .foregroundColor(.primary)
                                    .padding(.leading, 3 + (appState.completionProgress.contains(page.id) ? 0 : (page.titleImageSizeAdjustment * -1)) )
                                    .animation(Animation.timingCurve(0.3, 0.99, 0.43, 0.99, duration: 0.5), value: appState.completionProgress)
                                Spacer()
                            }
                            .padding(10)
                            .background(page.id == BasicsCourse[appState.currentPage].id ? Color.accentColor.opacity(colorScheme == .light ? 0.1 : 0.14) : Color.clear )
                            .cornerRadius(10)
                        }
                    }
                }
            }
        }
    }
    
    //  MARK: moreButton
    /// toggles a modal view showing background info about the app
    var moreButton: some View {
        Button {
            appState.showingAboutView.toggle()
        } label: {
            HStack{
                Image(systemName: "info.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.accentColor)
                    .frame(width: 17, height: 17)
                    .padding(5)
                    //.padding(.trailing, 2)
                    .transition(.scale.combined(with: .opacity))
                
                Text("About this app")
                    .font(.footnote)
                    .foregroundColor(.primary)
                Spacer()
            }
        }
    }
    
    //  MARK:supportButton
        /// toggles a modal view showing support options
        var supportButton: some View {
            Button {
                appState.showingSupportView.toggle()
            } label: {
                HStack{
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.accentColor)
                        .frame(width: 17, height: 17)
                        .padding(5)
                        //.padding(.trailing, 2)
                        .transition(.scale.combined(with: .opacity))
                    
                    Text("Support this app")
                        .font(.footnote)
                        .foregroundColor(.primary)
                    Spacer()
                }
            }
        }
    
}
