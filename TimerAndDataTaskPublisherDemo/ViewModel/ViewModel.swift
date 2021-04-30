//
//  ViewModel.swift
//  TestingCombine-0429
//
//  Created by Xing Zhao on 2021/4/29.
//

import Combine
import Foundation


final class ViewModel: ObservableObject {
    
    @Published var time = "Fetch Timing"
    @Published var users = [User]()

    private var subscriptions = Set<AnyCancellable>() // subscriptions will be released when viewmodel dealloc
    
    let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    init() {
       setupPublishers()
    }
    
    func fetchUsers() {
        requestUser()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.errorDescription as Any)
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &subscriptions)
    }
    
    private func setupPublishers() {
        Timer.publish(every: 1, on: .main, in: .common) // make sure you add the timer to the .common mode in Runloop, if not, the timer can be paused when scrolling the list
            .autoconnect()
            .receive(on: DispatchQueue.main) // receive elements on main thread in order to update UI
            .sink { [weak self] value in
                self?.time = self?.formatter.string(from: value) ?? ""
            }
            .store(in: &subscriptions)
    }
    
    private func requestUser() -> AnyPublisher<[User], APIError> {
        let postURL = URL(string: "https://jsonplaceholder.typicode.com/users")!
        return URLSession.shared.dataTaskPublisher(for: postURL)
            .receive(on: DispatchQueue.main)
            .mapError{ _ in APIError.unknown }
            .flatMap { (data, response) -> AnyPublisher<[User], APIError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(httpResponse.statusCode){
                    return Just(data)
                        .decode(type: [User].self, decoder: JSONDecoder())
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                }
                else {
                    return Fail(error: APIError.httpError).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
