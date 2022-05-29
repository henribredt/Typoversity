import SwiftUI

struct AboutView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var appVersion : String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown version"
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            HStack{
                Spacer()
                Image(systemName: "signature")
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
                
                Text("About this app (\(appVersion))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 7)
                Text("Typography Basics Crashcourse")
                    .font(.title2).fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            .padding(.top)
            .padding(.bottom, 30)
            
            SupporterView(text: "This app won an Apple 2022 SSC Award \u{00a0} 🎉")
                .padding(.bottom, 60)
                .onTapGesture {
                    if let url = URL(string: "https://www.wwdcscholars.com/s/5B432D62-F6F5-4D56-A901-828BEDB7D18B/2022") {
                        UIApplication.shared.open(url)
                    }
                }
              
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading, spacing: 35){
                    
                    CalloutView(
                        systemName: "person.crop.circle",
                        text: "The app was created as a submission to the Apple WWDC22 Swift Student Challenge by Henri Bredt in April 2022. It was selected as a winning submission by Apple in May 2022. I am a self-taught Swift developer and user experience design student. Learn more about me on my [Website](https://www.henribredt.de) or follow me on [Twitter](https://twitter.com/henricreates) or [Instagram](https://www.instagram.com/henricreates/)."
                    )
                    
                    
                    
                    CalloutView(
                        systemName: "book.closed.fill",
                        text: "During the creation of this app project I used the following resources as inspiration and for reference: [Typography Tutorial - 10 rules to help you rule type](https://www.youtube.com/watch?v=QrNi9FmdlxY), [Summary of key rules (Typography)](https://practicaltypography.com/summary-of-key-rules.html), [The Beginner's Guide to Typography in Web Design](https://blog.hubspot.com/website/website-typography), [Thinking with Type](https://www.amazon.de/-/en/Ellen-Lupton-ebook/dp/B07PQ9VP3Q/)"
                    )
                    
                    CalloutView(
                        systemName: "shippingbox.fill",
                        text: "This app builds upon the wonderful work that other people have made available open source. It incorporates the following third party library: [ConfettiSwiftUI](https://github.com/simibac/ConfettiSwiftUI.git) [(MIT License)](https://github.com/simibac/ConfettiSwiftUI/blob/master/LICENSE)"
                    )
                }
                .padding(.leading, 35)
                .padding(.trailing, 35)
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                InteractableView(basePadding: 12, sidePadding: 7) {  Text("Dismiss").font(.callout) }
            }
            .padding()
        }
        .padding(60)
    }
    
}

// MARK: Callout View
struct CalloutView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var systemName: String
    var text: String
    
    var body: some View {
        HStack(alignment: .top){
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.accentColor)
                .frame(width: 20, height: 20)
                .padding(10)
                .background(Color.accentColor.opacity(colorScheme == .light ? 0.1 : 0.14))
                .cornerRadius(10)
                .padding(.trailing, 20)
            Text(try! AttributedString(markdown: text))
                .font(.caption)
                .lineSpacing(1.1)
        }
    }
}


// MARK: Callout View
struct SupporterView: View {
    var text: String
    
    var body: some View {
        
        Text(text)
            .font(.caption)
            .foregroundColor(Color.primary.opacity(0.8))
            .padding(8)
            .padding(.leading, 6)
            .padding(.trailing, 6)
            .background(
                Color.primary.opacity(0.05)
                    .cornerRadius(30)
            )
    }
}

// MARK: String extension: toMarkdown()
extension String {
    func toMarkdown() -> AttributedString {
        do {
            return try AttributedString(markdown: self)
        } catch {
            print("Error parsing Markdown for string \(self): \(error)")
            return AttributedString(self)
        }
    }
}
