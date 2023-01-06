//
//  AllsportsViewModel.swift
//  Sports World
//
//  Created by sherif on 08/06/2022.
//

import Foundation
import Network


class AllsportsViewModel{
    
    let monitor = NWPathMonitor()
    let services:APIServices
    var bindingResultSports : (()->()) = {}
    var sportData:Sports?{
        didSet{
            bindingResultSports()
        }
    }
    
    init(services: APIServices) {
        self.services = services
    }
    
    
    
    
    func fetchSport(){

        APIServices.fetchAllSports {[weak self] sports in
            
            self?.sportData =  sports
            self?.bindingResultSports()
        }
    }

    
    
    func numberOfItemInsection()-> Int{
        
        return sportData?.sports.count ?? 0
    }
    
}
