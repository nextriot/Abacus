//
//  ParticipantTableViewCell.swift
//  Abacus
//
//  Created by Kyle Gillen on 06/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import UIKit

class ParticipantTableViewCell: UITableViewCell {

  @IBOutlet weak var playerPositionLabel: UILabel! {
    didSet {
      playerPositionLabel.layer.masksToBounds = true
      playerPositionLabel.layer.cornerRadius = 15.0
      playerPositionLabel.backgroundColor = Constants.Colors.MediumGrey
    }
  }

  @IBOutlet weak var playerNameLabel: UILabel! {
    didSet {
      playerNameLabel.textColor = Constants.Colors.DarkGrey
    }
  }
  @IBOutlet weak var playerScoreLabel: UILabel! {
    didSet {
      playerScoreLabel.textColor = Constants.Colors.DarkGrey
    }
  }

  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    // removes the left inset on table cells
    self.layoutMargins.left = 0.0
    self.preservesSuperviewLayoutMargins = false
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  // MARK: - Utility Methods
  func updatePlayerPositionLabel(isWinning: Bool) {
    if isWinning {
      playerPositionLabel.backgroundColor = Constants.Colors.Fuchsia
    }
  }

}
