import SwiftUI
import SFSymbolsPicker

struct CategoryModalView: View {
    
    @Binding var isPresented: Bool
    @State private var isIconsPresented: Bool = false
    @State private var icon: String = "scribble"
    
    @State private var title: String = ""
    @State private var hasTitleError: Bool = false
    
    var body: some View {
        VStack(spacing: 60) {
            Spacer()
            Text("Create new category")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding(.vertical)
            VStack(spacing: 20) {
                if hasTitleError {
                    TodoshError(errorText: "You must fill in this field")
                        .offset(y: title.isEmpty ? 0 : -25)
                        .scaleEffect(title.isEmpty ? 1 : 0.8, anchor: .leading)
                        .opacity(title.isEmpty ? 1 : 0)
                }
                TodoshTextField(text: $title, placeholder: Text("Title"), systemImageName: "pencil", onEditingChanged: {_ in
                    hasTitleError = false
                })
                Button(action: {
                    withAnimation {
                        isIconsPresented.toggle()
                    }
                }, label: {
                    HStack(alignment: .center) {
                        Text("Pick an icon")
                            .fontWeight(.bold)
                    }
                    .padding()
                })
                
                SFSymbolsPicker(isPresented: $isIconsPresented, icon: $icon, category: .health, axis: .vertical, haptic: true)
            }
            Spacer()
            Button(action: {
                if title.isEmpty {
                    hasTitleError = true
                    return
                }
                let category = Category(title: title, imageName: icon)
                DatabaseManager.shared.writeCategoryData(category: category)
                self.isPresented = false
            }, label: {
                Text("Create")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 60)
                    .background(Color("DarkGreen"))
                    .cornerRadius(16)
            })
            .padding()
            Spacer()
            .animation(.default)
        }
        .padding()
    }
}
