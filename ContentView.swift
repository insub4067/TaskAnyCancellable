import SwiftUI
import Combine

struct TaskCancelBagPractice: View {
    
    fileprivate let viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Button("EXECUTE") {
                viewModel.doSomething()
            }
            Button("CANCEL") {
                viewModel.cancel()
            }
        }
    }
}

fileprivate class ViewModel: ObservableObject {
    
    private var bag: Set<AnyCancellable> = []
    
    func doSomething() {
        Task {
            try await Task.sleep(for: .seconds(3))
            print("Task Done")
        }.store(in: &bag)
    }
    
    func cancel() {
        bag.removeAll()
    }
}

fileprivate extension Task {
    func store(in set: inout Set<AnyCancellable>) {
        set.insert(AnyCancellable(cancel))
    }
}
