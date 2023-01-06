//
//  FavouritesTableViewController.swift
//  Sports World
//
//  Created by sherif on 15/06/2022.
//

import UIKit
import SDWebImage

class FavouritesTableViewController: UITableViewController {

    //MARK: - Vars
    
    var arrcordata :[LeagueCoredataModel] = []
    
    
    //MARK: -applife cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        arrcordata = CoreDataStack.getLeagues()
//        self.tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrcordata = CoreDataStack.getLeagues()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return arrcordata.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")as? FavouriteCell else{return
            UITableViewCell()
        }
        
        cell.leagueImgView.sd_setImage(with: URL(string: (arrcordata[indexPath.row].strBadge)), placeholderImage: UIImage(named: Constants.placeholderImage))
        cell.leagueNameLBL.text = arrcordata[indexPath.row].leagueName
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: Constants.fromfavToLeagueDetils, sender: indexPath)
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { action, view, completion in
            
            self.arrcordata.remove(at: indexPath.row)
            CoreDataStack.delete(index: indexPath.row)
            self.tableView.reloadData()
            
        }
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        swipe.performsFirstActionWithFullSwipe = false
        return swipe
    }

}
 //MARK: - favouritesController Extension
extension FavouritesTableViewController {

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.fromfavToLeagueDetils{
            guard let selectedIndexPath = sender as? NSIndexPath else{ return }
              let leaguesDetailsVC = segue.destination as! LeagueDetailsViewController
            leaguesDetailsVC.title = "League Detials"
            leaguesDetailsVC.modalPresentationStyle = .fullScreen
            leaguesDetailsVC.leagueStr = arrcordata[selectedIndexPath.row].leagueName
            leaguesDetailsVC.LeagueId =  arrcordata[selectedIndexPath.row].leagueId
          }
    }
    
}
