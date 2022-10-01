//
//  Extensions.swift
//  EgnyteTest
//
//  Created by Aadil Majeed on 01/10/22.
//

import Foundation
import UIKit

typealias EGImageCompletion = ((Result<UIImage?, Error>) -> ())

extension UIImageView {
    
    func setImageWith(config: ImageConfiguration,
                      placeholder: UIImage? = nil,
                      completion: EGImageCompletion? = nil) -> Void {
        
        if(config.showLoader) {
            self.startAnimation()
        }
        self.image = placeholder
        DownloadManager.sharedManager.downlaodImageWith(config: config) { [ weak self, config, completion] result in
            DispatchQueue.main.async {
                self?.processResultOnMainThread(result: result, config: config, completion: completion)
            }
        }
    }
    
    private func processResultOnMainThread(result: Result<ImageResponse, ErrorResponse>, config: ImageConfiguration, completion: EGImageCompletion?) -> Void {
        
        switch result {
        case .success(let imageResponse):
            if(imageResponse.config.url == config.url) {
                if(imageResponse.config.showLoader) {
                    self.stopAnimation()
                }
                self.setImageWith(data: imageResponse.data, animationDuration: imageResponse.config.animationDuration)
                completion?(.success(self.image))
            }
        case .failure(let error):
            if(error.config.showLoader) {
                self.stopAnimation()
            }
            completion?(.failure(error.error))
            break
        }
    }
    
    private func setImageWith(data: Data, animationDuration: TimeInterval = 0.4) -> Void {
        let transition = CATransition()
        transition.duration = animationDuration
        transition.type = .fade
        self.layer.add(transition, forKey: nil)
        self.image = UIImage(data: data)
    }
    
    private func startAnimation() -> Void {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.color = .orange
        self.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let verticalConstraint = activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        self.addConstraints([horizontalConstraint, verticalConstraint])
        activityIndicatorView.startAnimating()
    }
    
    private func stopAnimation() -> Void {
        if let activityIndicatorView = self.subviews.filter({$0.isKind(of: UIActivityIndicatorView.self)}).first as? UIActivityIndicatorView{
            activityIndicatorView.stopAnimating()
            activityIndicatorView.removeFromSuperview()
        }
    }
}
