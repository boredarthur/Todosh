import Foundation
import RealmSwift

class TaskViewModel: ObservableObject {
    let realm = DatabaseManager.shared
    @Published var tasks: Results<Task> = DatabaseManager.shared.fetchData(type: Task.self)
    
    public func fetch() {
        self.tasks = DatabaseManager.shared.fetchData(type: Task.self)
    }
}
