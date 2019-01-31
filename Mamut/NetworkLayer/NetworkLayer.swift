//
//  NetworkLayer.swift
//  Mamut
//
//  Created by Merve on 31.01.2019.
//  Copyright © 2019 Merry. All rights reserved.
//

import UIKit

class NetworkLayer {
    
    typealias ErrorHandler = (String) -> Void
    typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void

    
    func get<T: Decodable>(urlString: String,
                           successHandler: @escaping (T) -> Void,
                           errorHandler: @escaping ErrorHandler ){
        
        
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if self.isSuccessCode(200) {
                if  let data = data {
                    
                    if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                        successHandler(responseObject)
                        return
                    }
                }
               
            }
                print("hata")
            
        }
        
        //TODO : Düzenle
//        let task = URLSession.shared.dataTask(with: urlString)  { (data,response,error) in
//
//            print(String(data: data!, encoding: .utf8)!)
//
//            do
//            {
//                let stories = try JSONDecoder().decode(DataModel.self, from: data!)
//                print(stories)
//
//            }
//            catch let error{
//                print("Json Parse Error : \(error)")
//            }
//
//
//            if error != nil {
//
//            }
//
//        }
//
//        task.resume()
        
        
    }
    
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    

 

}
