//
//  Leagues ViewController.swift
//  Sports World
//
//  Created by sherif on 05/06/2022.
//

import UIKit
import SDWebImage
import Network

class SportsViewController: UIViewController {
    
    //MARK: - Outlets : -
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    //MARK: - var & constants
    
    let monitor = NWPathMonitor()
    var viewModel : AllsportsViewModel?
    
    //MARK: - app lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkConnection()
        viewModel = AllsportsViewModel(services: APIServices())
        viewModel?.bindingResultSports = { [weak self ] in
            guard let self =  self  else{return}
            DispatchQueue.main.async {
                self.sportsCollectionView.reloadData()
            }
        }
        viewModel?.fetchSport()
    }

    //MARK: - Function Helper

    func checkConnection(){
        monitor.pathUpdateHandler = {  [ weak self] path in
            
            guard let self = self else{return}
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.viewModel?.fetchSport()
                }
            } else {
                let alert = UIAlertController(title: "No connection", message: "can not reloadData", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                 alert.addAction(action)
                self.present(alert, animated: true, completion:nil)
                print("Error in connection ")
            }
            print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "Monitor")

        monitor.start(queue: queue)
    }
    
}

//MARK: - Sports CollectionView Extension

extension SportsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemInsection() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->  UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentififer, for: indexPath) as? SportsCollectionViewCell else {return
            UICollectionViewCell()
        }
        cell.sportsNameLbl?.text = viewModel?.sportData?.sports[indexPath.row].strSport
        if let image = viewModel?.sportData?.sports[indexPath.row].strSportThumb {
            cell.sportthumbImage.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: Constants.placeholderImage))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: Constants.allLeaguesSegue, sender: indexPath)
    }
 

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (Constants.SCREENWIDTH / 2) - 10, height: (Constants.SCREENHEIGHT / 4) - 10)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
        return UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

//MARK: - sportsViewcontrollerExtension

extension SportsViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.allLeaguesSegue{
            guard let selectedIndexPath = sender as? NSIndexPath else{ return }
              let leaguesViewController = segue.destination as! LeagueViewController
            leaguesViewController.sportString = viewModel?.sportData?.sports[selectedIndexPath.row].strSport
          }
    }
    
    
}
