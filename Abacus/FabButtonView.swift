//
//  FabButtonView.swift
//  Abacus
//
//  Created by Kyle Gillen on 02/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import UIKit

class FabButtonView: UIView {

  
  var size: CGSize?
  var bgColor: UIColor?
  var iconName: String?
  var btnOrigin: CGPoint?
  var mainView: UIView?
  var parentView: UIView?
  var animator: UIDynamicAnimator?
  var delegate: UIViewController?
  
  init(size: CGSize = CGSize(width: 70.0, height: 70.0), bgColor: UIColor = .whiteColor(), iconName: String, superView: UIView!, mainView: UIView!) {
    
    
    self.size = size
    self.bgColor = bgColor
    self.iconName = iconName
    self.mainView = mainView
    self.parentView = superView
    
    super.init(frame: CGRectZero)
    
    config(size, bgColor: bgColor, iconName: iconName, superView: superView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: Utility Methods
  
  func config(size: CGSize, bgColor: UIColor, iconName: String, superView: UIView!) {
    
    let btnFrame = CGRect(x: (CGRectGetWidth(superView!.frame) - size.width) - 20 , y: (CGRectGetHeight(superView!.frame) - size.height) - 20, width: size.width, height: size.height)
    frame = btnFrame
    // set button origin to default origin
    self.btnOrigin = center
    
    backgroundColor = bgColor
    userInteractionEnabled = true
    
    // layer styles
    
    layer.masksToBounds = false
    layer.cornerRadius = 35.0
    layer.shadowOffset = CGSize(width: 0, height: 4.0)
    layer.shadowColor = UIColor.blackColor().CGColor
    layer.shadowRadius = 3.0
    layer.shadowOpacity = 0.15
    
    // add icon to button
    
    let iconSize = CGSize(width: size.height - 30.0, height: size.width - 30.0)
    let iconFrame = CGRect(x: (CGRectGetWidth(frame) - iconSize.width) / 2, y: (CGRectGetHeight(frame) - iconSize.height) / 2, width: iconSize.width, height: iconSize.height)
    let iconImageView = UIImageView(frame: iconFrame)
    iconImageView.image = UIImage(named: iconName)
    self.addSubview(iconImageView)
    
    // add gesture recognizers
    
    let tapGR = UITapGestureRecognizer(target: self, action: "tapped:")
    let panGR = UIPanGestureRecognizer(target: self, action: "panned:")
    self.attachGRs([tapGR, panGR])
    
    // add icon to superview
    
    superView.addSubview(self)
    
    // animate button
    animateOnInit(iconImageView)
    
    // animator for uidynamics
    animator = UIDynamicAnimator(referenceView: mainView!)

  }
  
  func attachGRs(gestureRecognizers: [UIGestureRecognizer]) {
    for gr in gestureRecognizers {
      self.addGestureRecognizer(gr)
    }
  }
  
  //MARK: Gesture Recognizers
  
  func tapped(sender: UITapGestureRecognizer) {
    self.animateOnTap()
    
    if self.delegate is ModalDelegate {
      let delegate = self.delegate as? ModalDelegate
      delegate?.configModal()
    }
//    presentGameOptions()
  }

  func panned(sender: UIPanGestureRecognizer) {
    let translation = sender.translationInView(mainView!)
    self.animateOnPan(sender, translation: translation)
  }

  
  // MARK: Animation Methods
  
  func animateOnInit(icon: UIImageView) {
    // animate fab button size & icon rotation on load
    
    self.transform = CGAffineTransformScale(self.transform, 0.01, 0.01)
    icon.transform = CGAffineTransformRotate(icon.transform, CGFloat(M_PI_2))
    icon.transform = CGAffineTransformScale(icon.transform, 0.01, 0.01)
    
    UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveEaseInOut], animations: {
      self.transform = CGAffineTransformScale(self.transform, 100.0, 100.0)
      icon.transform = CGAffineTransformRotate(icon.transform, CGFloat(M_PI_4 * 6))
      icon.transform = CGAffineTransformScale(icon.transform, 100.0, 100.0)
    }, completion: nil)
  }
  
  func animateOnTap() {
    
    if animator != nil {
      animator!.removeAllBehaviors()
    }
    
    let shadowOffsetY = self.layer.shadowOffset.height
    let shadowRadius = self.layer.shadowRadius
    
    // animate fab scale & shadow
    
    UIView.animateWithDuration(0.1, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: [UIViewAnimationOptions.CurveEaseOut], animations: {
      self.transform = CGAffineTransformScale(self.transform, 0.5, 0.5)
      self.layer.shadowOffset.height = shadowOffsetY / 2
      self.layer.shadowRadius = shadowRadius / 3
      }, completion: { _ in
        UIView.animateWithDuration(0.1, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.1, options: [.CurveEaseOut], animations: {
          self.transform = CGAffineTransformScale(self.transform, 2.3, 2.3)
          self.layer.shadowOffset.height = shadowOffsetY
          self.layer.shadowRadius = shadowRadius
          }, completion: { _ in
            UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: [.CurveEaseOut], animations: {
              self.transform = CGAffineTransformIdentity
            }, completion: nil)
        })
    })
  }
  
  func animateOnPan(gr: UIPanGestureRecognizer, translation: CGPoint) {
    
    if animator != nil {
      animator!.removeAllBehaviors()
    }
    
    let location = gr.locationInView(parentView)
    
    if gr.state == UIGestureRecognizerState.Began || gr.state == UIGestureRecognizerState.Changed {
      
      gr.view?.center = CGPoint(x: gr.view!.center.x + translation.x, y: gr.view!.center.y + translation.y)
      gr.setTranslation(CGPointZero, inView: self.mainView)
    } else if gr.state == UIGestureRecognizerState.Ended {
      animator!.removeAllBehaviors()
      
      let btnYPos = (CGRectGetHeight(self.mainView!.frame) - CGRectGetHeight(parentView!.frame)) + CGRectGetHeight(self.frame) - 15.0
      // 15.0 is needed as we're using the origin, not the Y position, to set the button:
      // The calculation, minus the 15, sums to: 563 - the position of the center Y point (on iPhone 6) - as we're using the origin, that leaves an overflow of
      // 35 (the buttons frame, 70 / 2). This means the bottom edge of the frame will end at 598 points, 5 points shy of the bottom of the screen.
      // We want a spacing of 20 on all sides - so we subtract 15 to give us that ample spacing.
      
      self.btnOrigin?.y = btnYPos
      
      let snapPoint = location.x <= (CGRectGetWidth(parentView!.frame) / 2) ? CGPoint(x: (CGRectGetWidth(self.frame) / 2) + 20.0, y: btnYPos) : self.btnOrigin!
      let snapBehavior = UISnapBehavior(item: self, snapToPoint: snapPoint)
      animator!.addBehavior(snapBehavior)
    }
  }
  

}
