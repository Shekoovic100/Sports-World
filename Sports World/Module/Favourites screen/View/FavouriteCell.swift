//
//  FavouriteCell.swift
//  Sports World
//
//  Created by sherif on 15/06/2022.
//

import UIKit

class FavouriteCell: UITableViewCell {

    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var leagueImgView: UIImageView!{
        
        didSet{
            leagueImgView.layer.cornerRadius = leagueImgView.frame.size.width/2
            leagueImgView.clipsToBounds = true
        }
        
    }
    @IBOutlet weak var leagueNameLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
