//
//  AppDelegate.swift
//  EgnyteTest
//
//  Created by Aadil Majeed on 14/09/22.
//

import Foundation

class HttpClient {
        
    public class func fetchUsers(url: URL, completionHandler: @escaping(_ result: Result<[User], EgnyteError>) -> Void) -> Void {
        let request = URLRequest(url: url)
        self.request(request: request, decodableType: [User].self) { result in
            OperationQueue.main.addOperation({
                completionHandler(result)
            })
        }
    }
    
    private class func request<T>(request: URLRequest, decodableType: T.Type, completionHandler: @escaping(_ result: Result<T, EgnyteError>) -> Void) -> Void where T : Decodable {
        
        let dataDecodableTypeType = decodableType
        
        self.request(request: request) { result in

            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let responseModel = try decoder.decode(dataDecodableTypeType.self, from: data)
                    completionHandler(.success(responseModel))
                } catch {
                    completionHandler(.failure(EgnyteError.generic(error.localizedDescription)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
                
            }
        }
    }
    
    private class func request(request: URLRequest, completionHandler: @escaping(_ result: Result<Data, EgnyteError>) -> Void) -> Void {
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                completionHandler(.failure(EgnyteError.generic(error.localizedDescription)))
                return
            }
            var responseCode = 500
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                responseCode = statusCode
            }
            // Parse JSON data
            if let serverData = data, responseCode == 200 {
                completionHandler(.success(serverData))
            }
            else if let error = error {
                completionHandler(.failure(EgnyteError.generic(error.localizedDescription)))
            }
            else {
                completionHandler(.failure(EgnyteError.generic("Somthing went wrong, Please try again later")))
            }
        })
        task.resume()
    }

}
