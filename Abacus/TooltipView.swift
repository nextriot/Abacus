//
//  TooltipView.swift
//  Abacus
//
//  Created by Kyle Gillen on 04/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import UIKit

class TooltipView: UIView {
  
  var labelText: String?
  var label: UILabel!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  init(labelText: String?) {
    super.init(frame: CGRectZero)
    self.frame = CGRect(x: 0, y: 0, width: 60.0, height: 28.0)
    self.backgroundColor = .blackColor()
    self.clipsToBounds = false
    self.layer.cornerRadius = 3.0
    
    // pointer triangle
    let pointerView = UIView(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(self.frame) / 6, height: CGRectGetWidth(self.frame) / 6))
    pointerView.center = CGPoint(x: CGRectGetWidth(self.frame) / 2, y: CGRectGetHeight(self.frame))
    pointerView.transform = CGAffineTransformRotate(pointerView.transform, CGFloat(M_PI_4))
    pointerView.backgroundColor = .blackColor()
    
    label = UILabel(frame: CGRect(x: 0, y: -1, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)))
    label.textColor = .whiteColor()
    label.font = UIFont(name: "Roboto-Bold", size: 17.0)
    label.textAlignment = .Center
    label.text = labelText
    
    self.layer.addSublayer(pointerView.layer)
    self.addSubview(label)
    
    // start the view off hidden to animate in later.
    self.hidden = true
    self.alpha = 0.0
  }
  
  // MARK: - Utility Methods
  
  func updateLabelText(labelText: String) {
    self.label.text = labelText
  }
  
  func animateStartPos(trackedViewOrigin: CGRect) {
    // TODO: ? - 15.0 because we need to add half the sliders thumb size?
    self.center = CGPoint(x: trackedViewOrigin.origin.x + 15.0, y: trackedViewOrigin.midY - 60.0)
    self.hidden = false
    
    UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .CurveEaseOut, animations: {
      self.center.y = trackedViewOrigin.midY - 40.0
      self.alpha = 1.0
    }, completion: nil)
  }
  
  func animateEndPos(trackedViewOrigin: CGRect) {
    UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .CurveEaseIn, animations: {
      self.center.y = trackedViewOrigin.midY - 60.0
      self.alpha = 0.0
      }, completion: { _ in
        self.hidden = true
    })
  }
  
  func updateToolTipPosition(viewToFollow: CGRect) {
    self.center = CGPoint(x: viewToFollow.origin.x + 15.0, y: viewToFollow.midY - 40.0)
  }
  
  

}
