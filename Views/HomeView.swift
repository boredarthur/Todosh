import SwiftUI
import RealmSwift

struct HomeView: View {
    @State private var isPresentingCreateTaskModal = false
    @State private var isPresentingCreateCategoryModal = false
    @State private var showTaskAlert: Bool = false
    @State private var currentIndex: Int = 0
    @State private var categories: [Category] = []
    @State private var countOfTasks: Int = 0
    
    @EnvironmentObject private var taskViewModel: TaskViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("Menu")
                }) {
                    Image(systemName: "line.3.horizontal.decrease")
                        .foregroundColor(Color("UIButton"))
                        .font(.system(size: 26.0))
                }
                Spacer()
            }
            .padding(.horizontal)
            Spacer().frame(height: 100)
            VStack {
                SnapCarousel(spacing: 170, trailingSpace: 170, index: $currentIndex, items: categories) { item in
                    GeometryReader { proxy in
                        CategoryButton(imageName: item.imageName)
                    }
                } onCategoryChange: {
                    if categories.count != 0 {
                        countOfTasks = getCountOfTasks()
                    }
                    let currentCategory = categories[currentIndex]
                    async {
                        await taskViewModel.reload(category: currentCategory)
                    }
                }
            }
            .frame(height: 180)
            VStack {
                if countOfTasks != 0 {
                    TasksView(category: $categories[currentIndex])
                } else {
                    Text("There is no tasks yet")
                }
            }
            Spacer()
            Menu {
                Button("Add task") {
                    if categories.count != 0 {
                        isPresentingCreateTaskModal.toggle()
                    } else {
                        showTaskAlert = true
                    }
                }
                Button("Add category") {
                    isPresentingCreateCategoryModal.toggle()
                }
            } label: {
                ZStack {
                    CreateTaskButtonView()
                        .sheet(isPresented: $isPresentingCreateTaskModal, content: {
                            TaskModalView(isPresented: self.$isPresentingCreateTaskModal)
                        })
                        .sheet(isPresented: $isPresentingCreateCategoryModal, onDismiss: {updateCategories()}, content: {
                            CategoryModalView(isPresented: self.$isPresentingCreateCategoryModal)
                        })
                }
            }
            .alert("Create at least one category, before creating any tasks", isPresented: $showTaskAlert) {
                Button("Alright", role: .cancel) {}
            }
        }
        .onAppear {
            updateCategories()
            if categories.count != 0 {
                countOfTasks = getCountOfTasks()
            }
        }
        .padding(20)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

extension HomeView {
    func updateCategories() {
        categories = DatabaseManager.shared.getAllCategories()
    }
    
    func getCountOfTasks() -> Int {
        return DatabaseManager.shared.getAllTasksForCategory(category: categories[currentIndex]).count
    }
    
    func getTasks() -> [Task] {
        return DatabaseManager.shared.getAllTasksForCategory(category: categories[currentIndex])
    }
}
