//
//  ViewController.swift
//  EgnyteTest
//
//  Created by Aadil Majeed on 01/10/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet private var userListButton: UIButton!

    let coordinator: HomeCoordinator
    let viewModel: HomeViewModel
    
    init(coordinator: HomeCoordinator, viewModel: HomeViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: "HomeViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        imageView.layer.cornerRadius = 8.0
        userListButton.layer.cornerRadius = 8.0
        let config = ImageConfiguration(url: viewModel.imageURL, showLoader: true)
        imageView.setImageWith(config: config, placeholder: UIImage(named: "placeholder"))
    }

    @IBAction func showUserList(_ sender: Any) -> Void {
        self.coordinator.showUserListView()
    }
}

