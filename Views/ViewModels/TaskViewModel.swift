import Foundation

class TaskViewModel: ObservableObject {
    @Published public var tasks: [Task] = []
    
    init() {}
    
    func reload(category: Category) async {
        tasks = await DatabaseManager.shared.getAllTasksForCategory(category: category)
    }
}
