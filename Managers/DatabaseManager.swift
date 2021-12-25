import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    lazy var realm = try! Realm(configuration: configuration)
    
    func writeTaskData(task: Task) {
        try! realm.write {
            realm.add(task)
        }
    }
    
    func writeCategoryData(category: Category) {
        try! realm.write {
            realm.add(category)
        }
    }
    
    func updateTaskDone(task: Task) {
        try! realm.write {
            task.isDone.toggle()
        }
    }
    
    func getAllCategories() -> [Category] {
        let categories = Array(realm.objects(Category.self))
        return categories
    }
    
    func getAllTasks() -> [Task] {
        let tasks = Array(realm.objects(Task.self))
        return tasks
    }
    
    func getTask(task: Task) -> Task? {
        let result = realm.object(ofType: Task.self, forPrimaryKey: task.taskID)
        return result
    }
    
    func deleteTask(task: Task) {
        try! realm.write {
            print(task)
            realm.delete(task)
        }
    }
    
    func getAllTasksForCategory(category: Category) -> [Task] {
        let tasks = Array(realm.objects(Task.self).filter("category = %@", category))
        return tasks
    }
 }
