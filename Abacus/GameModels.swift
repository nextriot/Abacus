//
//  GameModel.swift
//  Abacus
//
//  Created by Kyle Gillen on 02/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import Foundation

protocol CardGame {
  var players: Int? { get set }
  var teams: Int? { get set }
  var participantType: Int { get set }
  var timer: NSTimer? { get set }
  var winningScore: Int? { get set }
  var winningScoreReached: Bool? { get set }
}

struct CardGames {

  struct Canasta: CardGame {
    
    var players: Int?
    var teams: Int?
    var participantType: Int
    var timer: NSTimer?
    var winningScore: Int?
    var winningScoreReached: Bool?
    var meldRequiredScore: Int
    var meldRequired: Bool?
    
    init(players: Int?, teams: Int?, participantType: Int, timer: NSTimer?, winningScore: Int, winningScoreReached: Bool?, meldRequiredScore: Int, meldRequired: Bool?) {
      self.players = players
      self.teams = teams
      self.participantType = participantType
      self.timer = timer
      self.winningScore = winningScore
      self.winningScoreReached = winningScoreReached
      self.meldRequiredScore = Int(winningScore / 2) // VOO
      self.meldRequired = meldRequired
    }
  }

}