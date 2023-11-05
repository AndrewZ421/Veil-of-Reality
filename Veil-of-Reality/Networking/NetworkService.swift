//
//  NetworkService.swift
//  Veil-of-Reality
//
//  Created by Liu Xin on 11/5/23.
//

import Foundation






// Error type, use to deal network request error.
enum NetworkError:Error{
    case badURL
    case requestFailed
    case unknown
}

class NetworkService{
    
    static let shared = NetworkService()
    
    private init(){}
    
    /**
     Send a 'GET' request to server.

     - Parameters:
       - url: data task讲要获取数据的网络地址.
       - expecting: 将JSON数据解码成哪个Model class。
       - completion: 网络请求后调用，逃逸闭包。

     - Throws:
        - `badURL` If we can't find the URL.
        - `requestFailed` If we failed to send request to server.
        - `unknown` If we failed to recieve the data or the json data not match the model we need.

     - Returns: If success, 会return对应的Model类.
     */
    func fetch<T: Decodable>(url:URL?, expecting:T.Type,completion:@escaping (Result<T,NetworkError>)->Void){
        
        //Check whether URL is nil
        guard let url = url else {
            completion(.failure(.badURL))
            return
        }
        
        //Send Get request to Server url
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            //check whether request is successful.
            guard error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            //check whether we recieved data.
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                // 尝试解码JSON到指定的类型
                let decodedObject = try JSONDecoder().decode(expecting, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.unknown))
            }
        }
        
        task.resume()
    }
    
    /**
     Send a 'POST' request to server with data.

     - Parameters:
       - url: The URL to which the data will be posted.
       - data: The model instance that conforms to `Encodable` which will be sent to the server.
       - completion: The completion handler that's called when the request is completed. Escaping closure.

     - Throws:
       - `badURL` if the URL is nil.
       - `requestFailed` if there was an error in sending the request to the server.
       - `unknown` if there was an error encoding the data or the server responded with an error.

     - Returns: Calls completion with `Void` if successful or `NetworkError` if an error occurred.
     */
    func pushData<T: Encodable>(to url: URL?, data: T, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard let url = url else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set the request type to POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Set the content type to JSON
        
        do {
            let jsonData = try JSONEncoder().encode(data) // Encode the data to JSON
            request.httpBody = jsonData // Set the request body to the JSON data
            
            let task = URLSession.shared.dataTask(with: request) { _, response, error in
                guard error == nil else {
                    completion(.failure(.requestFailed))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    completion(.success(())) // Request was successful and server returned status code 200
                } else {
                    completion(.failure(.unknown)) // An unknown error occurred
                }
            }
            
            task.resume() // Start the network request
        } catch {
            completion(.failure(.unknown)) // An encoding error occurred
        }
    }

        
    
    
}
