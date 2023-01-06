//
//  TeamsViewModel.swift
//  Sports World
//
//  Created by sherif on 13/06/2022.
//

import Foundation
  
class TeamsViewModel {
    
    var services : APIServices?
    var bindingResultTeams : (()->()) = {}
    var sport:Countries?
    
    init(services:APIServices) {
        self.services = services
    }
    
    var TeamsData:AllTeams?{
        didSet{
            self.bindingResultTeams()
        }
    }
  
    func fetchTeams(StrLeague:String){

        APIServices.fetchTeams(strLeague: StrLeague, completionHandler: { teamsResponse in
            self.TeamsData = teamsResponse
            self.bindingResultTeams()
        })
     }
    
    
    
    func numberOfItemInsection()-> Int{
        
        return TeamsData?.teams.count ?? 0
    }
   
    
}
