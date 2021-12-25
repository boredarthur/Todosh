import SwiftUI

struct TasksView: View {
    
    @Binding var category: Category
    @EnvironmentObject private var taskViewModel: TaskViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color("Red"))
                Text("Today")
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                Spacer()
            }
            List(taskViewModel.tasks, id: \.self) { task in
                TaskView(task: task, category: category)
                    .listRowSeparator(.hidden)
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation(.spring()) {
                                let index = taskViewModel.tasks.firstIndex(of: task)
                                taskViewModel.tasks.remove(at: index!)
                                DatabaseManager.shared.deleteTask(task: task)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash.circle.fill")
                        }
                    }
            }
            .listStyle(.plain)
            .refreshable {
                await taskViewModel.reload(category: category)
            }
            .onAppear {
                async {
                    await taskViewModel.reload(category: category)
                }
            }
        }
        .onAppear {
            print("updated")
        }
        .frame(width: 290)
    }
}
