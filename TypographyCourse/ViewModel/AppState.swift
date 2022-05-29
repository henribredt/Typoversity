import SwiftUI

/// Manages and saves user progress persistantly
public class AppState: ObservableObject {
    
    public init() {
        
        // UNCOMMENT AFTER BETA
        // init currentPage with data from user defaults
        //currentPage = UserDefaults.standard.integer(forKey: "currentPage")
        
        // REMOVE AFTER BETA
        if UserDefaults.standard.integer(forKey: "currentPage") >= BasicsCourse.count {
            // default to 0 if stored vaule is larger (pervious beta had one page more, without the app could crash)
            currentPage = 0
        } else  {
            // if not use normal code
            print(UserDefaults.standard.integer(forKey: "currentPage"))
            currentPage = UserDefaults.standard.integer(forKey: "currentPage")
        }
        
        // init completionProgress with data from user defaults
        if let savedCompletionProgress = UserDefaults.standard.data(forKey: "completionProgress") {
            if let decodedCompletionProgress = try? JSONDecoder().decode([String].self, from: savedCompletionProgress) {
                completionProgress = decodedCompletionProgress
                return
            }
        }
        // Default to an empty array
        completionProgress = [String]()
    }
    
    /// Stores the currently opened page in user defaults and makes it available
    /// Used for restoring the last opened page when the user restarts the app
    @Published public var currentPage: Int {
        didSet{
            UserDefaults.standard.set(currentPage, forKey: "currentPage")
        }
    }
    
    /// Stores the page completion progress in user defaults and makes it available
    @Published public var completionProgress: [String] {
        didSet{
            if let encoded = try? JSONEncoder().encode(completionProgress) {
                UserDefaults.standard.set(encoded, forKey: "completionProgress")
            }
            
            // show support page if user completes course
            if (completionProgress.count * 100 / BasicsCourse.count) >= 100 {
                DispatchQueue.main.asyncAfter(deadline: .now() + (2.5) ) {
                    self.showingSupportView = true
                }
            }
        }
    }
    
    /// Store popover state
    @Published public var showingSupportView = false
    @Published public var showingAboutView = false
    
    /// Reset all user progress
    func resetCompletionProgress() {
        completionProgress = [String]()
        currentPage = 0
    }
    
    /// Save new view playgroundPage id as completed, will do noting, if the id already exists
    func appendToCompletionProgress(id: String) {
        if !completionProgress.contains(id) {
            completionProgress.append(id)
        }
    }
    
}
