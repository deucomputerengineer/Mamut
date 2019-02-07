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

    @IBOutlet weak var tableViewMovie: UITableView!
    
    var movieInformation : MovieInfoModel?
    var movieList = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        setupViews()
        
        
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/music-videos/top-music-videos/all/10/explicit.json")
        
        //getRequestWithAlamofire(url: "https://rss.itunes.apple.com/api/v1/us/music-videos/top-music-videos/all/10/explicit.json")
        
        let urlRequest = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: urlRequest)  { (data,response,error) in
            
            do
            {
                let stories = try JSONDecoder().decode(MovieInfoModel.self, from: data!)
                
                if let result = stories.feed?.results {
                    self.movieList = result
                    DispatchQueue.main.async{
                        self.initViews()
                    }
                }
            }
            catch let error{
                print("Json Parse Error : \(error)")
            }
            if error != nil {
                
            }
        }
        
        task.resume()
        
    }

    func setupViews(){
        
        let nib = UINib(nibName: "MovieInfoCell", bundle: nil)
        tableViewMovie.register(nib, forCellReuseIdentifier: "MovieCell")
        
    }
    
    func initViews(){
        
        tableViewMovie.dataSource = self
        tableViewMovie.delegate = self
        tableViewMovie.reloadData()
        
        
    }
    func getRequestWithAlamofire(url : String){
        
        Alamofire.request(url).responseData { (resData) -> Void in
            
            print(resData.result.value!)
            do
            {
                let stories = try JSONDecoder().decode(MovieInfoModel.self, from: resData.result.value!)
                print(stories)

            }catch let error {
                print("Json Parse Error : \(error)")
            }
            //let strOutput = String(data : resData.result.value!, encoding : String.Encoding.utf8)
        }
        
    }
}

extension ViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = movieList[indexPath.row]
        
        let cell : MovieInfoCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieInfoCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.configureCell(info: item.name!, imgStr: item.artworkUrl100!)
        
        return cell
    }


}

extension ViewController: UITableViewDelegate {
    
}

