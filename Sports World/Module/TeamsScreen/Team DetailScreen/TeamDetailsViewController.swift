//
//  TeamDetailsViewController.swift
//  Sports World
//
//  Created by sherif on 14/06/2022.
//

import UIKit
import SDWebImage
class TeamDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var countryLBL: UILabel!
    @IBOutlet weak var leagueLBL: UILabel!
    @IBOutlet weak var stadiumLBL: UILabel!
    @IBOutlet weak var SportLBL: UILabel!
    
    //MARK: - vars
    
    var teamInfo:Teams?
    
    
    //MARK: - applifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamDetailsInfo()
        
    }
    
    //MARK: - Helper Function
    
    func teamDetailsInfo(){
        teamImageView.sd_setImage(with: URL(string: "\(teamInfo?.strTeamBadge ?? "")"), placeholderImage: UIImage(named: Constants.placeholderImage))
        countryLBL.text = teamInfo?.strCountry
        leagueLBL.text = teamInfo?.strLeague
        SportLBL.text = teamInfo?.strSport
        stadiumLBL.text = teamInfo?.strStadium
    }

}
