//
//  OverviewTableViewCell.swift
//  Abacus
//
//  Created by Kyle Gillen on 01/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

  @IBOutlet weak var progressIndicatorView: UIView! {
    didSet {
      progressIndicatorView.backgroundColor = Constants.Colors.Gorse
      progressIndicatorView.layer.cornerRadius = 15.0
      // animate indicator scale
      progressIndicatorView.transform = CGAffineTransformScale(progressIndicatorView.transform, 0.1, 0.1)
      UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveEaseOut], animations: {
        self.progressIndicatorView.transform = CGAffineTransformScale(self.progressIndicatorView.transform, 10.0, 10.0)
      }, completion: nil)
    }
  }
  
  @IBOutlet weak var gameNameLabel: UILabel! {
    didSet {
      gameNameLabel.textColor = .whiteColor()
    }
  }
  
  @IBOutlet weak var gameStartedLabel: UILabel! {
    didSet {
      gameStartedLabel.textColor = .whiteColor()
    }
  }
  
  @IBOutlet weak var leaderNameScoreLabel: UILabel! {
    didSet {
      leaderNameScoreLabel.textColor = .whiteColor()
    }
  }
  
  @IBOutlet weak var leaderStatusLabel: UILabel! {
    didSet {
      leaderStatusLabel.textColor = .whiteColor()
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

}
