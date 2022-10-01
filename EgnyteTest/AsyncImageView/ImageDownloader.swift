//
//  ImageDownloader.swift
//  EgnyteTest
//
//  Created by Aadil Majeed on 01/10/22.
//

import Foundation

typealias EGDownloadCompletion = ((Result<ImageResponse, ErrorResponse>) -> ())

struct ImageResponse {
    let data: Data
    let config: ImageConfiguration
}

struct ErrorResponse: Error {
    let error: EgnyteError
    let config: ImageConfiguration
}


class DownloadManager {
    static let sharedManager = DownloadManager()
    private var memoryCache: [String: Data] = [:]
   
    private init() { }
    
    private lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "EgnyteTest Download queue"
        queue.maxConcurrentOperationCount = 3
        return queue
    }()

    func downlaodImageWith(config: ImageConfiguration, completion: @escaping EGDownloadCompletion) -> Void {
        if let imageData = memoryCache[config.url.absoluteString] {
            completion(.success(ImageResponse(data: imageData, config: config)))
            return
        }
        
        let imageDownloader = ImageDownloader(config: config) { result in
            switch result {
            case .success(let response):
                self.memoryCache[response.config.url.absoluteString] = response.data
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        self.downloadQueue.addOperation(imageDownloader)
    }
}


class ImageDownloader: Operation {
    private var imageURL: URL
    private var config: ImageConfiguration
    private var completion: EGDownloadCompletion
    private var session = URLSession.shared
    
    init(config: ImageConfiguration, completion: @escaping EGDownloadCompletion) {
        self.imageURL = config.url
        self.config = config
        self.completion = completion
        super.init()
    }

    override func main() {
        var request = URLRequest(url: imageURL)
        request.httpMethod = "GET"
        self.session.dataTask(with: request) { (data, response, error) in
            if let imageData = data {
                DispatchQueue.main.async {
                    self.completion(.success(ImageResponse(data: imageData, config: self.config)))
                }
            }
            else if let error = error {
                DispatchQueue.main.async {
                    self.completion(.failure(ErrorResponse(error: EgnyteError.generic(error.localizedDescription), config: self.config)))
                }
            }
            else {
                DispatchQueue.main.async {
                    self.completion(.failure(ErrorResponse(error: EgnyteError.generic("Someting went wrong. Please try again later"), config: self.config)))
                }
            }
        }.resume()
    }
}
