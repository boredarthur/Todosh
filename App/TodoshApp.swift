import SwiftUI

@main
struct TodoshApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    static var taskViewModel = TaskViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(TodoshApp.taskViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
}
