//
//  TableModels.swift
//  Abacus
//
//  Created by Kyle Gillen on 02/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import Foundation

struct Tables {

  struct PlayedGames {
    
    let completed: Bool
    let gameName: String
    let startedDateTime: String
    let leaderName: String
    let leaderScore: Int
    
    init(completed: Bool, gameName: String, startedDateTime: String, leaderName: String, leaderScore: Int) {
      self.completed = completed
      self.gameName = gameName
      self.startedDateTime = startedDateTime
      self.leaderName = leaderName
      self.leaderScore = leaderScore
    }
    
  }
  
  struct ParticipantPositions {
    var won: Bool
    var name: String
    var position: Int
    var winning: Bool
    var score: Int
    
    init(won: Bool, name: String, position: Int, winning: Bool, score: Int) {
      self.won = won
      self.name = name
      self.position = position
      self.winning = winning
      self.score = score
    }
  }

}