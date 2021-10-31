//
//  ControllerManager.swift
//  CoreDataCunsumption
//
//  Created by New Account on 10/31/21.
//

import Foundation

struct ControllerManager {
    private init(){
    }
    static let shared = ControllerManager()
    
    func request(_ urlPath: String, completionHandler: @escaping (Result<Data, NSError>) -> Void){
        let url = URL(string: urlPath)!
        
        let session = URLSession.shared
        let task = session.dataTask(with: url){
            (data, _, error) in
            
            if let parsedError = error{
                completionHandler(.failure(parsedError as NSError))
            }else if let parsedData = data {
                completionHandler(.success(parsedData))
            }
        }
        task.resume()
    }
}
