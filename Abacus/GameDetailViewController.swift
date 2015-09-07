//
//  GameDetailViewController.swift
//  Abacus
//
//  Created by Kyle Gillen on 06/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.estimatedRowHeight = 70.0
      // eliminate empty cell separators
      tableView.tableFooterView = UIView(frame: CGRectZero)
    }
  }

  @IBOutlet private weak var instructionView: UIView! {
    didSet {
      instructionView.backgroundColor = Constants.Colors.LightGrey
      let label: UILabel = instructionView.subviews[0] as! UILabel
      label.textColor = Constants.Colors.DarkGrey
    }
  }
  
  var participantData = [
    Tables.ParticipantPositions(won: false, name: "Flavia", position: 1, winning: false, score: 400),
    Tables.ParticipantPositions(won: false, name: "Valeria", position: 2, winning: false, score: 500),
    Tables.ParticipantPositions(won: false, name: "Kyle", position: 3, winning: false, score: 300)]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    navigationController?.setNavigationBarHidden(false, animated: true)
    styleNavBar(navigationController?.navigationBar)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Utility Methods
  
  func styleNavBar(navBar: UINavigationBar?) {
    if let _navBar = navBar {
      _navBar.barTintColor = Constants.Colors.Fuchsia
      _navBar.tintColor = .whiteColor()
      _navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

  }
  
  func calculateParticipantPosition(currentScore: Int, participantIdx: Int) -> String {
    // TODO: Compare current score to all other participants scores and return the position
    let allScores = participantData.map { $0.score }.sort(>)
    let combinedScore = allScores.reduce(0, combine: +)
    
    let scorePosition: Int = ({
      if let _scorePosition = allScores.indexOf(currentScore) {
        return _scorePosition + 1
      } else {
        return 0
      }
    })()
    
    let hasGameStarted = combinedScore > 0
    let playerPosition: Int = ({
      let position = hasGameStarted ? scorePosition : (participantIdx + 1)
      return position
    })()
    return String(Int(playerPosition))
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: - UITableView Data Source Methods

extension GameDetailViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return participantData.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath)
    return cell
  }
}

// MARK: - UITableView Delegate Methods

extension GameDetailViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    if let participantCell = cell as? ParticipantTableViewCell {
      let participant = participantData[indexPath.row]
      participantCell.playerNameLabel.text = participant.name
      
      let playerPosition = calculateParticipantPosition(participant.score, participantIdx: indexPath.row)
      participantCell.playerPositionLabel.text = playerPosition
      participantCell.playerScoreLabel.text = String(participant.score)
      participantCell.updatePlayerPositionLabel(Int(playerPosition) == 1)
    }
  }
  
}
