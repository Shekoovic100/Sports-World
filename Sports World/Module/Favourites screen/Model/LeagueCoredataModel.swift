//
//  LeagueCoredataModel.swift
//  Sports World
//
//  Created by sherif on 15/06/2022.
//

import Foundation


struct LeagueCoredataModel {
    
    let leagueName:String
    let strBadge:String
    let leagueId:String
    let youtubeUrl:String
    
    
    init (legueName:String,strBadge:String,leagueId:String,youtube:String){
        
        self.leagueName = legueName
        self.strBadge = strBadge
        self.leagueId = leagueId
        self.youtubeUrl = youtube
    }
}
