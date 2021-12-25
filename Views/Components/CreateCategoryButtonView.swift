import SwiftUI

struct CreateCategoryButtonView: View {
    var body: some View {
        ZStack {
            Text("+")
                .foregroundColor(.white)
            Circle()
                .frame(width: 100, height: 100)
                .foregroundStyle(.linearGradient(colors: [Color("LightGreen"), Color("DarkGreen")], startPoint: .top, endPoint: .bottom))
        }
    }
}
