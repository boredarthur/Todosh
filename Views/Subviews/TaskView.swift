import SwiftUI

struct TaskView: View {
    
    @State var task: Task
    @State var category: Category
    @State private var opacity: Double = 1
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(task.isDone ? Color("DarkGreen") : Color("SecondaryText"), lineWidth: 1.5)
                    .frame(width: 15, height: 15)
                
                if task.isDone {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color("DarkGreen"))
                }
            }
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                Text(task.taskDescription ?? "")
                    .font(.system(size: 10))
                    .foregroundColor(Color("SecondaryText"))
                    .fontWeight(.light)
                    .padding(.leading, 2)
            }
            .padding(.top, 12)
            Spacer()
            if task.hasDueDate {
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .frame(width: 13, height: 12)
                        .foregroundColor(Color("SecondaryText"))
                    Text(task.dueDate!, format: .dateTime.hour().minute())
                        .font(.system(size: 14))
                        .foregroundColor(Color("SecondaryText"))
                }
            }
        }
        .onTapGesture {
            DatabaseManager.shared.updateTaskDone(task: task)
            task = DatabaseManager.shared.getTask(task: task)!
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.3), {
                    self.opacity = task.isDone ? 0.3 : 1
                })
            }
        }
        .opacity(opacity)
    }
}
