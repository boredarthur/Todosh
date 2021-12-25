import SwiftUI

struct TodoshDropdown: View {
    
    var title: String
    @Binding var selection: Int
    var options: [String]
    
    @State private var onceOpened: Bool = false
    @State private var showOptions: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                Text(title)
                    .fontWeight(onceOpened ? .bold : .light)
                    .foregroundColor(onceOpened ? Color(.white) : Color("GrayishText"))
                Spacer()
                Text(options[selection])
                    .foregroundColor(onceOpened ? Color(.white) : Color.black.opacity(0.6))
                    .fontWeight(onceOpened ? .bold : .regular)
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                    .foregroundColor(onceOpened ? Color(.white) : Color(.black))
            }
            .font(Font.headline.weight(.medium))
            .padding(.horizontal, 12)
            .padding(.vertical, 20)
            .background(onceOpened ? Color("DarkGreen") : Color("Grayish"))
            .cornerRadius(16)
            .onTapGesture {
                withAnimation(Animation.spring().speed(2)) {
                    showOptions = true
                    onceOpened = true
                }
            }
            
            if showOptions {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Font.headline.weight(.bold))
                        .foregroundColor(.white)
                    HStack {
                        Spacer()
                        ForEach(options.indices, id: \.self) { identifier in
                            if identifier == selection {
                                Text(options[identifier])
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(4)
                                    .onTapGesture {
                                        withAnimation(Animation.spring().speed(2)) {
                                            showOptions = false
                                        }
                                    }
                            } else {
                                Text(options[identifier])
                                    .font(.system(size: 12))
                                    .onTapGesture {
                                        withAnimation(Animation.spring().speed(2)) {
                                            selection = identifier
                                            showOptions = false
                                        }
                                    }
                        }
                            Spacer()
                        }
                    }
                    .padding(.vertical, 2)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color("DarkGreen"))
                .cornerRadius(16)
                .foregroundColor(.white)
                .transition(.opacity)
            }
        }
        .padding()
    }
}
