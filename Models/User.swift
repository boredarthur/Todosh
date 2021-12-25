import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var user_id = UUID().uuidString
    @objc dynamic var full_name = ""
    @objc dynamic var email = ""
    
    override static func primaryKey() -> String? {
        return "user_id"
    }
}
