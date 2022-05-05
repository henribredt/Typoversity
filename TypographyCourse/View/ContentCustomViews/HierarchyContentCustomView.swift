import SwiftUI

struct HierarchyContentCustomView: View {
    @State private var selectedType = 0
    @State private var font: Font = .system(size: 30, weight: .regular, design: .default)
    @State private var text = "Primary Heading"
    @State private var info = "30 pt, regular"
    
    var body: some View {
        VStack {
            Picker("Favorite Color", selection: $selectedType, content: {
                Text("H1").tag(0)
                Text("H2").tag(1)
                Text("Body").tag(2)
            })
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedType){ newValue in
                switch newValue {
                case 0:
                    font = .system(size: 30, weight: .regular, design: .default)
                    text = "Primary Heading"
                    info = "30 pt, regular"
                case 1:
                    font = .system(size: 17, weight: .semibold, design: .default)
                    text = "Secondary Heading"
                    info = "17 pt, semibold"
                case 2:
                    font = .system(size: 15, weight: .regular, design: .default)
                    text = "Body text"
                    info = "16 pt, regular"
                default:
                    font = .system(size: 30, weight: .medium, design: .default)
                    text = "Unknown selection"
                    info = "?"
                }
            }
            
            HStack(alignment: .center){
                Text(text)
                    .font(font)
                    .padding()
                Spacer()
                Text(info)
                    .font(.system(size: 13, weight: .regular, design: .default))
                    .foregroundColor(.secondary)
                    .padding()
            }
            .frame(height: 60)
        }
        
    }
}

