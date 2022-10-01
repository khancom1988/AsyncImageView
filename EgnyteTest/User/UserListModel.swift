//
//  UserListModel.swift
//  EgnyteTest
//
//  Created by Aadil Majeed on 01/10/22.
//

import Foundation

typealias UserRequestCompletion = ((Result<[User], EgnyteError>) -> ())

protocol UserListProtocol {
    var apiEndPoint: URL {get}
    var usersPublisher: UserRequestCompletion? {get set}
    var users: [User] {get}
    func fetchUsers() -> Void
}


class UserListModel: UserListProtocol {
   
    var apiEndPoint: URL
    
    private(set) var users: [User] = []
    
    var usersPublisher: UserRequestCompletion?

    init(url: URL) {
        self.apiEndPoint = url
    }
    
    func fetchUsers() {
       
        HttpClient.fetchUsers(url: apiEndPoint) { [weak self] result in

            switch result {
            case .success(let users):
                self?.users = users
                self?.usersPublisher?(.success(users))
            case .failure(let error):
                print(error.localizedDescription)
                self?.usersPublisher?(.failure(error))
                break
            }
        }
        
    }
}
