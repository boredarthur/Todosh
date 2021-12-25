import SwiftUI
import RealmSwift

class Category: Object, Identifiable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var imageName: String = ""
    
    convenience init(title: String, imageName: String) {
        self.init()
        self.title = title
        self.imageName = imageName
    }
}
