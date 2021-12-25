import SwiftUI

struct CreateTaskButtonView: View {
    var body: some View {
        Button(action: {}, label: {
            Image(systemName: "plus")
                .foregroundColor(Color.white)
                .font(Font.title.weight(.medium))
        })
            .frame(width: 80, height: 80)
            .background(LinearGradient(gradient: Gradient(colors: [
                Color("LightGreen"),
                Color("DarkGreen")
            ]),
            startPoint: .top,
            endPoint: .bottom))
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 0,
                                        y: 2)
    }
}
