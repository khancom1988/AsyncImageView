//
//  EgnyteTestTests.swift
//  EgnyteTestTests
//
//  Created by Aadil Majeed on 01/10/22.
//

import XCTest
@testable import EgnyteTest

class EgnyteTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHomeView() -> Void {
        let navigationController = UINavigationController()
        let coordinator = HomeCoordinator(navigationController: navigationController)
        let viewModel = HomeViewModel(url: URL(string: kImageURL)!)
        let vc = HomeViewController(coordinator: coordinator, viewModel: viewModel)
        coordinator.start()
        vc.loadViewIfNeeded()
               
        let placeholderImage = UIImage(named: "placeholder")!
       
        XCTAssertNotNil(vc.imageView.image, "Image view should have an placeholder image")
        
        let expectation = XCTestExpectation(description: "Wait for image to load")
        _ = XCTWaiter().wait(for: [expectation], timeout: 8)

        XCTAssertNotNil(vc.imageView.image, "Image view should have an image")

        XCTAssertFalse(image(image1: placeholderImage, isEqualTo: vc.imageView.image!))
    }
    
    func testUserList() {
        let navigationController = UINavigationController()
        let coordinator = HomeCoordinator(navigationController: navigationController)
        let viewModel = UserListViewModel_Fake(url: URL(string: kUsersURL)!)
        let vc = UserListViewController(coordinator: coordinator, viewModel: viewModel)
        coordinator.start()
        vc.loadViewIfNeeded()
        XCTAssertTrue(vc.viewModel.users.count != 0)
    }

    func image(image1: UIImage, isEqualTo image2: UIImage) -> Bool {
        let data1 = image1.pngData()!
        let data2 = image2.pngData()!
        return data1 == data2
    }

}
