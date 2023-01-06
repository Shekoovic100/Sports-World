//
//  API Service.swift
//  Sports World
//
//  Created by sherif on 07/06/2022.
//

import Foundation
import Alamofire

protocol AllSportsService{
    
    
    static func fetchAllSports(completionHandler: @escaping (Sports?) -> Void)
    static func fetchEvents(leagueId:String,completionHandler: @escaping (AllEvents?)->Void)
    static func getLatestResultsByLeagueId(leagueId: String,completionHandler: @escaping (AllEvents?) -> Void)
    static func fetchLeagues(strSport:String,completionHandler:@escaping (AllLeagues?)-> Void )
    static func fetchTeams(strLeague:String,completionHandler:@escaping(AllTeams?)->Void)
}

class APIServices : AllSportsService{

    //MARK:-Fetch All Sports
    
    static func fetchAllSports(completionHandler: @escaping (Sports?) -> Void){
        
        AF.request("https://www.thesportsdb.com/api/v1/json/2/all_sports.php")
            .responseDecodable(of: Sports.self) { response in
            guard let sportsRespose = response.value else{return}
            completionHandler(sportsRespose)
           
        }
    }
    
    //MARK:-fetch ALL leagues :
    
    static func fetchLeagues(strSport:String,completionHandler:@escaping (AllLeagues?)-> Void ){
        
        let baseUrl : String = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?"
         let parameters:Parameters = ["s":strSport]
        AF.request(baseUrl, method: .get,parameters: parameters, encoding: URLEncoding.queryString,headers: nil)
            .responseDecodable(of: AllLeagues.self) { response in
            guard let allLeaguesResponse = response.value else {return}
            completionHandler(allLeaguesResponse)
            
        }
        
    }
    //MARK:-Fetch all Teams By strLeague : -
    
    static func fetchTeams(strLeague:String,completionHandler:@escaping(AllTeams?)->Void){
        
        let Url : String = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?"
       let parameters : Parameters = ["l" :strLeague]
        AF.request(Url, method: .get,parameters: parameters ,encoding: URLEncoding.queryString).responseDecodable(of: AllTeams.self) {response in
            
            guard let allTeamsResponse = response.value else{return}
            completionHandler(allTeamsResponse)
            
        }
    }
    
    //MARK:-Fetch Events By league ID
    
    static func fetchEvents(leagueId:String,completionHandler: @escaping (AllEvents?)->Void){
        
        let urlEvent = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?"
        let parameters : Parameters = ["id" : leagueId]
        AF.request(urlEvent, method: .get,parameters: parameters ,encoding: URLEncoding.queryString).responseDecodable(of: AllEvents.self){ resposne in
            
            guard let allEvenetsResponse =  resposne.value else{return}
            completionHandler(allEvenetsResponse)
        }
    }
    
    
    //MARK:-Fetch results 
    static func getLatestResultsByLeagueId(leagueId: String,completionHandler: @escaping (AllEvents?) -> Void) {
        let url = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?"
            let paramaters : Parameters = ["id" : leagueId]
            AF.request( url, method: .get,parameters: paramaters, encoding: URLEncoding.queryString)
                .responseDecodable(of: AllEvents.self) { (response) in
                  
                    guard let sportsResponse = response.value else {
                        print("getLatestResultsByLeagueId else")
                        return }
                    completionHandler(sportsResponse)
            }
        }

}
