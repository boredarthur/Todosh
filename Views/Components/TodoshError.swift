import SwiftUI

struct TodoshError: View {
    
    @State var errorText: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "xmark")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundColor(.white)
            Text(errorText)
                .font(.system(size: 12))
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(10)
        .background(Color("Red"))
        .cornerRadius(16, corners: [.topLeft, .topRight, .bottomRight])
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
