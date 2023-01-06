//
//  TeamsCollectionCell.swift
//  Sports World
//
//  Created by sherif on 07/06/2022.
//

import UIKit

class TeamsCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var cellContentView: UIView!{
        
        didSet{
            
            cellContentView.layer.borderWidth = 2
            cellContentView.layer.borderColor = UIColor.gray.cgColor
            cellContentView.layer.masksToBounds = true
            cellContentView.clipsToBounds = true
        }
        
    }
    @IBOutlet weak var teamsImageView: UIImageView!{
        didSet{
            
            teamsImageView.layer.cornerRadius = teamsImageView.frame.size.height / 4
        } 
    }
    
}
