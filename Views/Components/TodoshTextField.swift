import SwiftUI

struct TodoshTextField: View {
    
    @Binding var text: String
    let placeholder: Text
    let systemImageName: String
    @State var onEditingChanged:((Bool) -> Void)
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack(spacing: 20) {
                Image(systemName: systemImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundColor(text.isEmpty ? Color("GrayishText") : .white)
                ZStack(alignment: .leading) {
                    placeholder
                        .foregroundColor(Color("GrayishText"))
                        .offset(y: text.isEmpty ? 0 : -25)
                        .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                        .opacity(text.isEmpty ? 1 : 0)
                    TextField("", text: $text, onEditingChanged: onEditingChanged)
                        .foregroundColor(text.isEmpty ? .black : .white)
                        .font(Font.headline.weight(.bold))
                        .multilineTextAlignment(.leading)
                }
            }
            .animation(.default)
        }
        .padding()
        .background(text.isEmpty ? Color("Grayish") : Color("DarkGreen"))
        .cornerRadius(10)
        .padding(.horizontal)
        .foregroundColor(.black)
    }
}
