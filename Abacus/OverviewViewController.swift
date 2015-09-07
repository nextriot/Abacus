//
//  OverviewViewController.swift
//  Abacus
//
//  Created by Kyle Gillen on 01/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController, ModalDelegate {
  
  @IBOutlet private weak var summaryView: UIView!
  
  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.estimatedRowHeight = 70.0
      tableView.contentInset.top = 20.0
      // eliminate empty cell separators
      tableView.tableFooterView = UIView(frame: CGRectZero)
    }
  }
  
  private var fabView: FabButtonView!
  
  let playedGames = [
    Tables.PlayedGames(completed: false, gameName: "Canasta", startedDateTime: "15:09 08/08/15", leaderName: "Flavia", leaderScore: 1500),
    Tables.PlayedGames(completed: true, gameName: "Canasta", startedDateTime: "16:09 09/08/15", leaderName: "Valeria", leaderScore: 1600),
    Tables.PlayedGames(completed: false, gameName: "Canasta", startedDateTime: "17:09 10/08/15", leaderName: "Kyle", leaderScore: 1700)]

    override func viewDidLoad() {
      super.viewDidLoad()
    }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    view.backgroundColor = Constants.Colors.Fuchsia
    
    // fab button
    fabView = FabButtonView(iconName: "icon-plus", superView: summaryView, mainView: view)
    fabView.delegate = self
//    presentGameOptions()
//    presentGame()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBarHidden = true
  }
  
  override func viewDidDisappear(animated: Bool) {
    // remove fabView when modal is presented,
    // as the view does not get destroyed when it does.
    fabView.removeFromSuperview()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

}

// MARK: Utility Methods

extension OverviewViewController {
  
  func presentGameOptions() {
    configModal()
  }
  
  func presentGame() {
    configDetailView()
  }
  
  func configDetailView() {
    self.performSegueWithIdentifier("GameDetailSegue", sender: self)
  }
  
  func configModal() {
    
    let gameOptionsVC = storyboard!.instantiateViewControllerWithIdentifier("gameOptions")
    let navController = UINavigationController(rootViewController: gameOptionsVC)
    navController.modalPresentationStyle = .FormSheet
    presentViewController(navController, animated: true, completion: nil)
    
  }
  
  func removeViewConstraints(view: UIView) {
    for constraint in view.constraints {
      view.removeConstraint(constraint)
    }
  }
  
}

// MARK: UITableViewDataSource

extension OverviewViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return playedGames.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("OverviewCell") as! OverviewTableViewCell
    return cell
  }
  
}


// MARK: UITableViewDelegate

extension OverviewViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 70.0
  }
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    
    if let overviewCell = cell as? OverviewTableViewCell {
      let playedGame = playedGames[indexPath.row]
      
      if playedGame.completed {
        overviewCell.progressIndicatorView.backgroundColor = Constants.Colors.Aquamarine
      }
      
      overviewCell.gameNameLabel.text = playedGame.gameName
      overviewCell.gameStartedLabel.text = playedGame.startedDateTime
      
      let numberFormatter = NSNumberFormatter()
      numberFormatter.numberStyle = .DecimalStyle
      let leaderScore = numberFormatter.stringFromNumber(playedGame.leaderScore)!
      let leaderString = playedGame.leaderName + " " + leaderScore
      
      let attributedString = NSMutableAttributedString(string: leaderString, attributes: [NSFontAttributeName: UIFont(name: "RobotoCondensed-Regular", size: 18.0)!])
      attributedString.setAttributes([NSFontAttributeName: UIFont(name: "RobotoCondensed-Light", size: 18.0)!], range: (leaderString as NSString).rangeOfString(leaderScore))
      
      overviewCell.leaderNameScoreLabel.attributedText = attributedString
      overviewCell.leaderStatusLabel.text = playedGame.completed ? "Winner".uppercaseString : "Winning".uppercaseString

    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    presentGame()
  }
  
}