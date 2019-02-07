//
//  MovieInfoCellTableViewCell.swift
//  Mamut
//
//  Created by Merve on 7.02.2019.
//  Copyright © 2019 Merry. All rights reserved.
//

import UIKit

class MovieInfoCell: UITableViewCell {

    @IBOutlet weak var lblInformation: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblInformation.font = UIFont(name: "Helvetica", size: 16)
        lblInformation.textColor = UIColor.green
        lblInformation.numberOfLines = 0
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(info : String , imgStr : String){
        
        lblInformation.text = info
         DispatchQueue.global().async {
            let img = self.convertToImage(imgStr)
            DispatchQueue.main.async {
                self.imgMovie.image = img
            }
        }
        

    }
    
    func convertToImage(_ imageStr : String) -> UIImage {

        var img : UIImage?
        let url = URL(string: imageStr)
        
        do{
            let data = try Data(contentsOf: url!)
            img = UIImage(data: data)

        }catch{
            print(error)
        }
        
        return img!
        
    }
    
}
