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
    
    UIView.animateWithDuration(0.2) {
      self.backgroundColor = Constants.Colors.Fuchsia
      self.setTitleColor(.whiteColor(), forState: .Normal)
    }
    
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesEnded(touches, withEvent: event)
    
    UIView.animateWithDuration(0.2) {
      self.backgroundColor = .clearColor()
      self.setTitleColor(Constants.Colors.Fuchsia, forState: .Normal)
    }
  }
  
  override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    super.touchesCancelled(touches, withEvent: event)
    
    UIView.animateWithDuration(0.2) {
      self.backgroundColor = .clearColor()
      self.setTitleColor(Constants.Colors.Fuchsia, forState: .Normal)
    }
  }



}
