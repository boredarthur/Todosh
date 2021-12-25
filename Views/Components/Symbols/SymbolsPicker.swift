import SwiftUI
import Foundation

public struct SFSymbolsPicker: View {
    
    
    @Binding public var isPresented: Bool
    @Binding public var icon: String
    let category: SymbolCategory
    let axis: Axis.Set
    let haptic: Bool
    
    public init(isPresented: Binding<Bool>, icon: Binding<String>, category: SymbolCategory, axis: Axis.Set = .horizontal, haptic: Bool = true) {
        self._isPresented = isPresented
        self._icon = icon
        self.category = category
        self.axis = axis
        self.haptic = haptic
    }

    
    public var body: some View {
        
        if isPresented {
            ScrollView(self.axis) {
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 20) {
                    
                    ForEach(symbols[category.rawValue]!, id: \.hash) { icon in
                        
                        Image(systemName: icon)
                            .font(.system(size: 25))
                            .animation(.linear)
                            .foregroundColor(self.icon == icon ? Color("DarkGreen") : Color.primary)
                            .onTapGesture {
                                
                                // Assign binding value
                                withAnimation {
                                    self.icon = icon
                                }
                                
                                // Generate haptic
                                if self.haptic {
                                    self.impactFeedback(style: .medium)
                                }
                            }
                        
                    }.padding(.top, 5)
                }
            }
        }
            
    }
    
    private func impactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()
            generator.impactOccurred()
    }
}




struct SFSymbolsPicker_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolsPicker(isPresented: .constant(false), icon: .constant(""), category: .commerce, axis: .horizontal)
    }
}
