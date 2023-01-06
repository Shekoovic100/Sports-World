//
//  FavouritesViewModel.swift
//  Sports World
//
//  Created by sherif on 15/06/2022.
//


import UIKit
import CoreData

class CoreDataStack {
    
    
    static let appDelegate  = UIApplication.shared.delegate as? AppDelegate
    static let context = appDelegate?.persistentContainer.viewContext
    
    
    // Save Data
    static func SaveData(sportsModel:LeagueCoredataModel){
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Favourites", in: context!)else {return}
        let sportObject = NSManagedObject.init(entity: entity, insertInto: context)
        
        sportObject.setValue(sportsModel.leagueName, forKey: "leagueName")
        sportObject.setValue(sportsModel.leagueId, forKey: "leagueId")
        sportObject.setValue(sportsModel.strBadge, forKey: "strBadge")
        sportObject.setValue(sportsModel.youtubeUrl, forKey: "leagueYoutubeUrl")
        do{
            try context?.save()
        }catch{
            print("error")
        }
    }
    
    // Get Data
    
    static func getLeagues()->[LeagueCoredataModel] {
        
        var  sportsArr:[LeagueCoredataModel] = []
        let fetchLeagues = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourites")
        
        do {
            
            let result  = try context?.fetch(fetchLeagues) as! [NSManagedObject]
            
            for sports in result {
                let name = sports.value(forKey: "leagueName") as? String
                let id  = sports.value(forKey: "leagueId") as? String
                let image = sports.value(forKey: "strBadge") as? String
                let youtubeUrl = sports.value(forKey: "leagueYoutubeUrl") as? String
                let sportsModelObject  = LeagueCoredataModel(legueName: name ?? "", strBadge: image ?? "", leagueId: id ?? "", youtube: youtubeUrl ?? "")
                
                sportsArr.append(sportsModelObject)
            }
        }catch{
            print("Error !!!")
        }
        
        return sportsArr
    }
    
    
    // Delete
    
    static func delete(index:Int) {
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourites")
        
        do{
            let result = try context?.fetch(fetchData) as! [NSManagedObject]
            let deleteItem = result[index]
            context?.delete(deleteItem)
            try context?.save()
        }catch{
            print("error")
        }
    }

}
