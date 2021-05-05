//
//  NetworkManager.swift
//  Posts
//
//  Created by Gam Doung on 23/2/2564 BE.
//

import UIKit
import Foundation

protocol NetworkManager {
    
    
}

class Network: NetworkManager {
    static func getPosts(completion: @escaping ((DummyPosts?) -> Void)){
        if let url = URL(string: "https://dummyapi.io/data/api/post") {
           var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("602f651fe019b975f7815306", forHTTPHeaderField: "app-id")
            
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                guard let data = data else {return}
                
                do{
                    let result =  try JSONDecoder().decode(DummyPosts.self, from: data)
                    completion(result)
                    print("Result: \(result)")
                }
                catch (let error){
                    completion(nil)
                    print("\(error)")
                        
                }
            }
            task.resume()
        }
    }
    static func getComentID(id: String, completion: @escaping ((DummyComments?) -> Void)){
        if let url = URL(string: "https://dummyapi.io/data/api/post/\(id)/comment") {
           var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("602f651fe019b975f7815306", forHTTPHeaderField: "app-id")
            
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                guard let data = data else {return}
                
                do{
                    let result =  try JSONDecoder().decode(DummyComments.self, from: data)
                    completion(result)
                    print("Result: \(result)")
                }
                catch (let error){
                    completion(nil)
                    print("\(error)")
                        
                }
            }
            task.resume()
        }
    }

    
}
 
