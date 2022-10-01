//
//  UserListViewModel_Fake.swift
//  EgnyteTestTests
//
//  Created by Aadil Majeed on 01/10/22.
//

import Foundation
@testable import EgnyteTest

class UserListViewModel_Fake: UserListProtocol {
   
    var apiEndPoint: URL
    
    var usersPublisher: UserRequestCompletion?
    
    var users: [User] = []
    
    init(url: URL) {
        self.apiEndPoint = url
    }

    func fetchUsers() {
        
        let path = Bundle.main.path(forResource: "fake_users", ofType: "json")!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            do {
                let responseModel = try decoder.decode([User].self, from: data)
                self.usersPublisher?(.success(responseModel))
                self.users = responseModel
            } catch {
                self.usersPublisher?(.failure(EgnyteError.generic(error.localizedDescription)))
            }
        }
        catch {
            self.usersPublisher?(.failure(EgnyteError.generic(error.localizedDescription)))
        }
    }
    
    
}
