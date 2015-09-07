//
//  BorderedButton.swift
//  Abacus
//
//  Created by Kyle Gillen on 07/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import UIKit

class BorderedButton: UIButton {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tintColor = Constants.Colors.Fuchsia
    self.layer.borderWidth = 1.0
    self.layer.borderColor = Constants.Colors.Fuchsia.CGColor
    self.layer.cornerRadius = 3.0
    self.setTitleColor(Constants.Colors.Fuchsia, forState: .Normal)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)
    print("Began!")
    
    titleLabel?.highlighted = false
    titleLabel?.alpha = 1.0
    UIView.animateWithDuration(0.1) {
      self.alpha = 0.3
    }
    
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesEnded(touches, withEvent: event)
    print("Ended")
    print(highlighted)
    UIView.animateWithDuration(0.1) { self.alpha = 1.0 }
  }



}
