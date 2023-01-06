//
//  AllResultViewModel.swift
//  Sports World
//
//  Created by sherif on 12/06/2022.
//

import Foundation

class AllResultViewModel{
    
    
    var services : APIServices?
    var sport:Countries?
    
    var bindingResults: (()->()) = {}
    init(services:APIServices) {
        self.services = services
    }
    
    
    var resultData:AllEvents?{
        didSet{
            self.bindingResults()
        }
    }
    
    
    
    func fetchResults(leagueId:String){
        APIServices.getLatestResultsByLeagueId(leagueId: leagueId) { resultEsponse in
            self.resultData = resultEsponse
            self.bindingResults()
        }
    }
    
    func numberOfItemInsection()-> Int{
        
        return resultData?.events?.count ?? 0
    }
    
    
}
