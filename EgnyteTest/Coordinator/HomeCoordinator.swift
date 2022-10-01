//
//  HomeCoordinator.swift
//  EgnyteTest
//
//  Created by Aadil Majeed on 01/10/22.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
   
    var navigationController: UINavigationController
    
    var signInCompletion: (() -> Void)?
    
    deinit {
        print("HomeCoordinator deinit called")
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        let imageURL = URL(string: kImageURL)!
        let viewModel = HomeViewModel(url: imageURL)
        let vc = HomeViewController.init(coordinator: self, viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showUserListView() -> Void {
        let viewModel = UserListModel(url: URL(string: kUsersURL)!)
        let vc = UserListViewController(coordinator: self, viewModel: viewModel)
        navigationController.present(vc, animated: true)
    }
}
