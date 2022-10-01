//
//  UserListViewController.swift
//  EgnyteTest
//
//  Created by Aadil Majeed on 01/10/22.
//

import UIKit

class UserListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    let coordinator: HomeCoordinator
    var viewModel: UserListProtocol
    
    init(coordinator: HomeCoordinator, viewModel: UserListProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: "UserListViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.registerCell()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.viewModel.fetchUsers()
        
        self.viewModel.usersPublisher = { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(_):
                weakSelf.tableView.reloadData()
                break
            case .failure(let error):
                weakSelf.showAlert(message: """
                                            \(error.localizedDescription).
                                            Please try again later.
                                            """)
                break
            }
        }
    }
        
    private func showAlert(message: String) -> Void {
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }

    private func registerCell() -> Void {
        self.tableView.register(UINib(nibName: UserTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: UserTableViewCell.identifier)
    }

}


extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        cell.selectionStyle = .none
        let user = self.viewModel.users[indexPath.row]
        cell.titleLabel?.text = user.id
        if let imageUrl = URL(string: user.urls.regular) {
            let config = ImageConfiguration(url: imageUrl, showLoader: true)
            cell.userImageView?.setImageWith(config: config, placeholder: UIImage(named: "placeholder"))
        }
        return cell
    }
}
