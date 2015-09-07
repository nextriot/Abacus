//
//  TooltipSlider.swift
//  Abacus
//
//  Created by Kyle Gillen on 04/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import UIKit

class TooltipSlider: UISlider {
  
  let tooltipView: TooltipView
  var thumbPosition: CGRect?
  var multiplier: Int?

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  
  required init?(coder aDecoder: NSCoder) {
    
    tooltipView = TooltipView(labelText: "N/A")
    super.init(coder: aDecoder)
    
    self.addSubview(tooltipView)
    
//    tooltipView.animateStartPos(self.thumbPosition?.origin)
    
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)
    
    let track = trackRectForBounds(self.bounds)
    let thumbPos = thumbRectForBounds(self.bounds, trackRect: track, value: value)
    
    updateLabelForMultiplier()
    
    thumbPosition = thumbPos
    tooltipView.animateStartPos(thumbPos)
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesEnded(touches, withEvent: event)
    
    let track = trackRectForBounds(self.bounds)
    let thumbPos = thumbRectForBounds(self.bounds, trackRect: track, value: value)
    
    updateLabelForMultiplier()
    
    thumbPosition = thumbPos
    tooltipView.animateEndPos(thumbPos)
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesMoved(touches, withEvent: event)
    
    let track = trackRectForBounds(self.bounds)
    let thumbPos = thumbRectForBounds(self.bounds, trackRect: track, value: value)
    
    updateLabelForMultiplier()
    
    thumbPosition = thumbPos
    tooltipView.updateToolTipPosition(thumbPos)
  }
  
  func updateLabelForMultiplier() {
    let sliderValue: String
    if let _multiplier = self.multiplier {
      sliderValue = String(Int(value) * _multiplier)
    } else {
      sliderValue = String(Int(value))
    }
    tooltipView.updateLabelText(sliderValue)
  }

}
