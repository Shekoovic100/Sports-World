//
//  SportsCollectionViewCell.swift
//  Sports World
//
//  Created by sherif on 05/06/2022.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
//MARK:- Cell Outlets: -
    
    
    @IBOutlet weak var cellContentView: UIView!{
        didSet{
            
            cellContentView.layer.borderWidth = 2
            cellContentView.layer.borderColor = UIColor.gray.cgColor
            cellContentView.layer.masksToBounds = true
            cellContentView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var sportthumbImage: UIImageView!{
        didSet{
            
            sportthumbImage.layer.cornerRadius = sportthumbImage.frame.size.height / 4
        }
        
    }
    @IBOutlet weak var sportsNameLbl: UILabel! {
        
        didSet{
            
            sportsNameLbl.textColor = .white
        
        }
    }
    
  

}
