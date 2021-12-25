import SwiftUI

struct CategoryButton: View {
    public var imageName: String
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .frame(width: 180, height: 180)
                .foregroundStyle(.linearGradient(colors: [Color("LightGreen"), Color("DarkGreen")], startPoint: .top, endPoint: .bottom))
            Image(systemName: imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
        }
    }
}
