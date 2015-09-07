//
//  GameOptionsViewController.swift
//  Abacus
//
//  Created by Kyle Gillen on 02/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import UIKit

class GameOptionsViewController: UIViewController, ModalDelegate {
  
  @IBOutlet private weak var summaryView: UIView! {
    didSet {
      let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(summaryView.frame), height: 1.0))
      topBorder.backgroundColor = Constants.Colors.MediumGrey
      summaryView.layer.addSublayer(topBorder.layer)
    }
  }
  
  @IBOutlet private weak var containerView: UIView!
  
  private var fabView: FabButtonView!

  override func viewDidLoad() {
    super.viewDidLoad()
    styleNavBar(navigationController!.navigationBar)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    let backBtnItem = UIBarButtonItem(image: UIImage(named: "icon-overview"), style: .Plain, target: self, action: "dismissModal")
    title = "Game Options"
    navigationItem.leftBarButtonItem = backBtnItem
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    fabView = FabButtonView(bgColor: Constants.Colors.Fuchsia, iconName: "icon-tick", superView: summaryView, mainView: view)
    fabView.delegate = self
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
  
  // MARK: Utiility Methods
  func styleNavBar(navBar: UINavigationBar) {
    navBar.barTintColor = Constants.Colors.Fuchsia
    navBar.translucent = false
    navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    navBar.tintColor = .whiteColor()
  }
  
  // MARK: Modal Delegate Methods
  
  func configModal() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func dismissModal() {
    dismissViewControllerAnimated(true, completion: nil)
  }


}