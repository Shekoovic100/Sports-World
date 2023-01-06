//
//  All LeaguesViewModel.swift
//  Sports World
//
//  Created by sherif on 08/06/2022.
//

import Foundation


class AllLeaguesViewModel {
    
    
    var services : APIServices?
    var bindingResultLeagues : (()->()) = {}

    init(services:APIServices){
        self.services = services
    }

    var leaguesData: AllLeagues? {
        didSet{
            bindingResultLeagues()
        }
    }

    func FetchDataLeagues(sportString:String){
        
        APIServices.fetchLeagues(strSport: sportString ) { [weak self] leaguesResponse  in
            guard let self = self else{return}
                self.leaguesData = leaguesResponse
                self.bindingResultLeagues()
            
        }
    }
    
    
    func numberOfItemInsection()-> Int{
        
        return leaguesData?.countries?.count ?? 0
    }
    
}

