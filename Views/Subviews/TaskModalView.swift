import SwiftUI

struct TaskModalView: View {
    
    @Binding var isPresented: Bool
    
    @State var title: String = ""
    @State var description: String = ""
    @State var hasDescription: Bool = false
    @State var hasDueDate: Bool = false
    @State var categories: [Category] = DatabaseManager.shared.getAllCategories()
    @State var dueDate: Date = Date()
    @State var selection: Int = 0
    
    @State var hasTitleError: Bool = false
    @State var hasDescriptionError: Bool = false
    
    var body: some View {
        Spacer()
        Text("Create new task")
            .foregroundColor(.black)
            .fontWeight(.bold)
            .font(.largeTitle)
        Spacer()
        VStack(spacing: 20) {
            if hasTitleError {
                TodoshError(errorText: "You must fill in this field")
                    .offset(y: title.isEmpty ? 0 : -25)
                    .scaleEffect(title.isEmpty ? 1 : 0.8, anchor: .leading)
                    .opacity(title.isEmpty ? 1 : 0)
            }
            TodoshTextField(text: $title, placeholder: Text("Title"), systemImageName: "pencil", onEditingChanged: {_ in
                hasTitleError = false
            })
            Toggle("Has description?", isOn: $hasDescription)
                .toggleStyle(.button)
            if hasDescription {
                if hasDescriptionError {
                    TodoshError(errorText: "You must fill in this field")
                        .offset(y: description.isEmpty ? 0 : -25)
                        .scaleEffect(description.isEmpty ? 1 : 0.8, anchor: .leading)
                        .opacity(description.isEmpty ? 1 : 0)
                }
                TodoshTextField(text: $description, placeholder: Text("Description"), systemImageName: "square.and.pencil", onEditingChanged: {_ in
                    hasDescriptionError = false
                })
            }
            TodoshDropdown(title: "Category", selection: $selection, options: categories.map { $0.title })
            Toggle("Has due dute?", isOn: $hasDueDate)
                .toggleStyle(.button)
            if hasDueDate {
                DatePicker(selection: $dueDate, in: Date()...) {}
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            }
        }.animation(.default)
        Spacer()
        Button(action: {
            if title.isEmpty {
                hasTitleError = true
                return
            }
            
            if hasDescription {
                if description.isEmpty {
                    hasDescriptionError = true
                    return
                }
            }
            
            let task = Task(title: title, taskDescription: description, category: categories[selection], hasDueDate: hasDueDate, dueDate: dueDate)
            DatabaseManager.shared.writeTaskData(task: task)
            self.isPresented = false
        }, label: {
            Text("Create")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical, 20)
                .padding(.horizontal, 60)
                .background(Color("DarkGreen"))
                .cornerRadius(16)
        })
        .padding()
    }
}
