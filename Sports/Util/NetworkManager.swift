//
//  NetworkManager.swift
//  Sports
//
//  Created by Dean Parreno on 22/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = {
        return NetworkManager()
    }()
    
    func fetch(for url: URL, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: URLRequest(url: url), completionHandler: { (data, response, error) in
            if let data = data {
                completionHandler(data)
            } else if let error = error {
                errorHandler(error)
            }
        })
        task.resume()
    }
    
}

