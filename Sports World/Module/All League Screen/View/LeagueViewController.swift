//
//  LeagueViewController.swift
//  Sports World
//
//  Created by sherif on 05/06/2022.
//

import UIKit

class LeagueViewController: UITableViewController {
    
    //MARK: -  vars
    var leaguesViewModel : AllLeaguesViewModel?
    var sportString:String?
    
    //MARK: - app life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaguesViewModel = AllLeaguesViewModel(services: APIServices())
        leaguesViewModel?.bindingResultLeagues = { [weak self]  in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        leaguesViewModel?.FetchDataLeagues(sportString: sportString ?? "")
    }
    
    //MARK: - tableview Datasources
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return leaguesViewModel?.numberOfItemInsection() ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentififer, for: indexPath)as? LeagueTableViewCell else{
            return
                UITableViewCell()
        }
        cell.legaueNameLBL.text = leaguesViewModel?.leaguesData?.countries?[indexPath.row].strLeague
        
        if let image = leaguesViewModel?.leaguesData?.countries?[indexPath.row].strYoutube {
            cell.youtubeButton.sd_setBackgroundImage(with: URL(string: image), for:.highlighted,placeholderImage: UIImage(named: Constants.placeholderImage))
        }
        
        if let image = leaguesViewModel?.leaguesData?.countries?[indexPath.row].strBadge {
            cell.leagueBadgeImageView.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: Constants.placeholderImage))
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: Constants.leagueDetailsSegue, sender: indexPath)
    }
    
}

//MARK: - LeagueViewController extension
extension LeagueViewController{
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.leagueDetailsSegue{
            guard let selectedIndexPath = sender as? NSIndexPath else{ return }
            guard let DetailsLeagueViewController = segue.destination as? LeagueDetailsViewController else {return}
            DetailsLeagueViewController.LeagueId = leaguesViewModel?.leaguesData?.countries?[selectedIndexPath.row].idLeague
            DetailsLeagueViewController.leagueStr = leaguesViewModel?.leaguesData?.countries?[selectedIndexPath.row].strLeague
            DetailsLeagueViewController.arrLeagues = leaguesViewModel?.leaguesData?.countries?[selectedIndexPath.row]
        }
    }
    
}
