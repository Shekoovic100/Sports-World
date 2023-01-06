//
//  LeagueDetailsViewController.swift
//  Sports World
//
//  Created by sherif on 06/06/2022.
//

import UIKit

class LeagueDetailsViewController: UIViewController {
    
    //MARK: - outlets :
    @IBOutlet weak var upComingCollectionView: UICollectionView!
    @IBOutlet weak var latestResultCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    //MARK: -vars
    
    var allEventsViewModel:AllEventsViewModel?
    var allresultViewModel:AllResultViewModel?
    var allTeamsViewModel : TeamsViewModel?
    var favouritesViewModel:CoreDataStack?
    
    var LeagueId:String?
    var leagueStr:String?
    var strImage:String?
    var urlYoutube:String?
    var arrLeagues:Countries?
    var arrCoredataModel:LeagueCoredataModel!
    //MARK: - App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allEventsViewModel = AllEventsViewModel(services: APIServices())
        allresultViewModel = AllResultViewModel(services: APIServices())
        allTeamsViewModel = TeamsViewModel(services: APIServices())
        
        passDataToFirstCollection()
        passDataToSecondCollection()
        passDataToThirdCollection()
        
        allEventsViewModel?.fetchEvent(leagueId: LeagueId ?? "")
        allresultViewModel?.fetchResults(leagueId: LeagueId ?? "")
        allTeamsViewModel?.fetchTeams(StrLeague: leagueStr ?? "")
    }
    
    //MARK: - Function Helper
    
    
    @IBAction func addToFavourites(_ sender: UIBarButtonItem) {
        
        CoreDataStack.SaveData(sportsModel:  arrCoredataModel ?? LeagueCoredataModel(legueName: leagueStr ?? "", strBadge: strImage ?? "", leagueId: LeagueId ?? "", youtube: urlYoutube ?? ""))
        
        let alert = UIAlertController(title: " Saved Success", message: "League addedTo favourites", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    func passDataToFirstCollection(){
        
        allEventsViewModel?.bindingResultEvents = { [weak self] in
            guard let self =  self  else{return}
            DispatchQueue.main.async {
                self.upComingCollectionView.reloadData()
            }
        }
    }
    
    
    func passDataToSecondCollection(){
        
        allresultViewModel?.bindingResults = { [weak self] in
            guard let self =  self  else{return}
            DispatchQueue.main.async {
                self.latestResultCollectionView.reloadData()
            }
        }
    }
    
    
    func passDataToThirdCollection(){
        
        allTeamsViewModel?.bindingResultTeams = { [weak self] in
            guard let self =  self  else{return}
            DispatchQueue.main.async {
                self.teamsCollectionView.reloadData()
            }
        }
    }
    
    
}
//MARK: - Extensions

extension LeagueDetailsViewController :
    UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == upComingCollectionView {
            
            return allEventsViewModel?.numberOfItemInsection() ?? 0
            
        }else if collectionView == latestResultCollectionView{
            
            return allresultViewModel?.numberOfItemInsection() ?? 0
        }else{
            
            return allTeamsViewModel?.numberOfItemInsection() ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == upComingCollectionView {
            // First Collection Latest Events
            guard  let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentififer, for: indexPath) as? UPComingEventCollectionCell else{ return
                UICollectionViewCell()
            }
            cell.eventNameLBL.text = allEventsViewModel?.EventsData?.events?[indexPath.row].strEvent
            cell.eventDateLBL.text = allEventsViewModel?.EventsData?.events?[indexPath.row].dateEvent
            cell.eventTimeLBL.text = allEventsViewModel?.EventsData?.events?[indexPath.row].strTimestamp
            return cell
            
        }else if collectionView == latestResultCollectionView{   // SecondCollectionView Latest Result
            
            guard  let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentififer, for: indexPath) as? LatestResultCollectionCell else{ return
                UICollectionViewCell()
            }
            cell.fisrScoreLBL.text = allresultViewModel?.resultData?.events?[indexPath.row].intHomeScore
            cell.secondScoreLBL.text = allresultViewModel?.resultData?.events?[indexPath.row].intAwayScore
            if let image = allresultViewModel?.resultData?.events?[indexPath.row].strThumb{
                cell.resultImageView.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: Constants.placeholderImage))
            }
            return cell
        }else{
            guard  let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentififer, for: indexPath) as? TeamsCollectionCell else{ return
                UICollectionViewCell()
            }
            
            if let image = allTeamsViewModel?.TeamsData?.teams[indexPath.row].strTeamBadge{
                cell.teamsImageView.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: Constants.placeholderImage))
            }
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView{
            
            self.performSegue(withIdentifier: Constants.TeamDetailsSegue, sender: indexPath)
            
        }
        
    }
    
    
}
//MARK: - league detailsVC  Extension
extension LeagueDetailsViewController{
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.TeamDetailsSegue{
            guard let selectedIndexPath = sender as? NSIndexPath else{ return }
            guard let teamDetailsVC = segue.destination as? TeamDetailsViewController else {return}
            teamDetailsVC.teamInfo = allTeamsViewModel?.TeamsData?.teams[selectedIndexPath.row]
        }
        
    }
}
