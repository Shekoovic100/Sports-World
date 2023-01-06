//
//  Deatils ViewModel.swift
//  Sports World
//
//  Created by sherif on 09/06/2022.
//

import Foundation


class AllEventsViewModel {
    
    var services : APIServices?
    var bindingResultEvents : (()->()) = {}
    
    
    init(services:APIServices) {
        self.services = services
    }
    
    var EventsData:AllEvents?{
        didSet{
            self.bindingResultEvents()
        }
    }
  
    func fetchEvent(leagueId:String){

        APIServices.fetchEvents(leagueId: leagueId ) { eventsResponse in
            
            self.EventsData = eventsResponse
            self.bindingResultEvents()
        }
    }
    
    
    func numberOfItemInsection()-> Int{
        
        return EventsData?.events?.count ?? 0
    }
   
}
