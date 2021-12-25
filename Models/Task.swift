import Foundation
import RealmSwift

class Task: Object, Identifiable {
    @objc dynamic var taskID = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var taskDescription: String?
    @objc dynamic var category: Category?
    @objc dynamic var hasDueDate: Bool = true
    @objc dynamic var dueDate: Date?
    @objc dynamic var isDone: Bool = false
    
    override static func primaryKey() -> String? {
        return "taskID"
    }
    
    convenience init(title: String, taskDescription: String, category: Category?, hasDueDate: Bool, dueDate: Date?) {
        self.init()
        
        self.title = title
        self.taskDescription = taskDescription
        self.hasDueDate = hasDueDate

        if let category = category {
            self.category = category
        }
        
        if hasDueDate {
            if let dueDate = dueDate {
                self.dueDate = dueDate
            }
        } else {
            self.dueDate = nil
        }
    }
}
