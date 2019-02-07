//
//  ViewController.swift
//  Mamut
//
//  Created by Merve on 23.01.2019.
//  Copyright © 2019 Merry. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("hello girls!!!")
        print("Mine deneme")
        
        let url = URL(string: "https://www.omdbapi.com/?apikey=9b10485a&t=X-men")
        let urlRequest = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: urlRequest)  { (data,response,error) in
            
            print(String(data: data!, encoding: .utf8)!)
            
            do
            {
                let stories = try JSONDecoder().decode(MovieInfoModel.self, from: data!)
                print(stories)
                
            }
            catch let error{
                print("Json Parse Error : \(error)")
            }
            
            
            if error != nil {
                
            }
            
        }
        
        task.resume()
        
    }


}

