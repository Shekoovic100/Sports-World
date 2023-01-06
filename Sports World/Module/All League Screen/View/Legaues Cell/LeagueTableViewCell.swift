//
//  LeagueTableViewCell.swift
//  Sports World
//
//  Created by sherif on 05/06/2022.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {


    @IBOutlet weak var youtubeButton: UIButton!
    
    @IBOutlet weak var legaueNameLBL: UILabel!
    @IBOutlet weak var leagueBadgeImageView: UIImageView!{
        didSet{
            leagueBadgeImageView.layer.cornerRadius = leagueBadgeImageView.frame.size.width / 4
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    @IBAction func youtubeButtonPressed(_ sender: UIButton) {
        
        UIApplication.shared.openURL(NSURL(string:"http://www.youtube.com/watch?v=videoId")! as URL)

        }
        
 
    
    
  
}
