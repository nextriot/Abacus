//
//  GameOptionsTableViewController.swift
//  Abacus
//
//  Created by Kyle Gillen on 03/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import UIKit

class GameOptionsTableViewController: UITableViewController {

  @IBOutlet private var segmentedControls: [UISegmentedControl]! {
    didSet {
      segmentedControls.forEach { $0.tintColor = Constants.Colors.Fuchsia }
    }
  }
  
  @IBOutlet private var sliders: [TooltipSlider]! {
    didSet {
      sliders.forEach { $0.tintColor = Constants.Colors.Fuchsia }
    }
  }
  
  @IBOutlet private var labels: [UILabel]! {
    didSet {
      labels.forEach { $0.textColor = Constants.Colors.Fuchsia }
    }
  }
  
  @IBOutlet private weak var participantsLabel: UILabel!
  @IBOutlet private weak var goalLabel: UILabel!
  @IBOutlet private weak var timerLabel: UILabel!
  
  private var participantsType: UISegmentedControl?
  private var participantsSlider: TooltipSlider?
  private var goalMultiplier: UISegmentedControl?
  private var goalSlider: TooltipSlider?
  private var timerValue: UISegmentedControl?
  
  private let tooltip = TooltipView(labelText: "0")

  
  var gameOptions: CardGames.Canasta?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if DeviceType.IS_IPHONE_4_OR_LESS {
      tableView.scrollEnabled = true
    }
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    participantsType = segmentedControls[0]
    participantsSlider = sliders[1]
    goalMultiplier = segmentedControls[1]
    goalSlider = sliders[0]
    timerValue = segmentedControls[2]
    
    updateParticipantsLabel(participantsType?.selectedSegmentIndex, participants: participantsSlider?.value)
    updateGoalLabel(goalMultiplier?.selectedSegmentIndex, goal: goalSlider?.value, slider: nil)
    updateTimerLabel(timerValue?.selectedSegmentIndex)
    
  }


  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: IBActions
  
  @IBAction func participantsSliderChanged(sender: TooltipSlider) {
    updateParticipantsLabel(participantsType?.selectedSegmentIndex, participants: sender.value)
  }
  
  @IBAction func participantsSegmentedControlChanged(sender: UISegmentedControl) {
    updateParticipantsLabel(sender.selectedSegmentIndex, participants: participantsSlider?.value)
  }
  
  @IBAction func goalSliderChanged(sender: TooltipSlider) {
    updateGoalLabel(goalMultiplier?.selectedSegmentIndex, goal: sender.value, slider: sender)
  }
  
  @IBAction func goalSegmentedControlChanged(sender: UISegmentedControl) {
    updateGoalLabel(sender.selectedSegmentIndex, goal: goalSlider?.value, slider: nil)
  }
  
  @IBAction func timerSegmentedControlChanged(sender: UISegmentedControl) {
    updateTimerLabel(sender.selectedSegmentIndex)
  }
  
  // MARK: Utility Methods
  
  func updateParticipantsLabel(type: Int?, participants: Float?) {
    if let _type = type, let _participants = participants {
      
      var typeOfParticipants: String
      
      switch (_type, _participants) {
        case let (t, p) where t == 0 && p < 2: typeOfParticipants = "Player"
        case let (t, p) where t == 1 && p < 2: typeOfParticipants = "Team"
        case let (t, p) where t == 0 && p > 1: typeOfParticipants = "Players"
        case let (t, p) where t == 1 && p > 1: typeOfParticipants = "Teams"
        default: typeOfParticipants = "Participants"
      }
      
      let numberOfParticipants = String(Int(_participants))
      participantsLabel.text = numberOfParticipants + " " + typeOfParticipants
    }
  }
  
  func updateGoalLabel(multiplier: Int?, goal: Float?, slider: TooltipSlider?) {
    if let _multiplier = multiplier, let _goal = goal {
      
      let powerOfMultiplier: Int
      var winningGoal = Int(_goal)
      
      switch _multiplier {
        case 0:
          powerOfMultiplier = 10
          goalSlider?.maximumValue = 50
        case 1:
          powerOfMultiplier = 100
          goalSlider?.maximumValue = 50
        case 2:
          powerOfMultiplier = 1000
          goalSlider?.maximumValue = 10
          // sets slider to 5000 in case where previous selection
          // exceeded 10 as, the multiplier would set the goal
          // in excess of 10_000
          if _goal > 10.0 {
            goalSlider?.value = 5.0
            winningGoal = Int(goalSlider!.value)
          }
        default:
          powerOfMultiplier = 10
      }
      
      // update multiplier property of slider so that tooltipView will reflect the correct value
      slider?.multiplier = powerOfMultiplier
      
      let goalLabelText = winningGoal * powerOfMultiplier
      goalLabel.text = String(goalLabelText) + " " + "Points"
    }
  }
  
  func updateTimerLabel(time: Int?) {
    if let _time = time {
      var timeValue: Int
      switch _time {
        case 0: timeValue = 0
        case 1: timeValue = 5
        case 2: timeValue = 15
        case 3: timeValue = 45
        case 4: timeValue = 60
        default: timeValue = 0
      }
      
      let timerLabelText = timeValue > 0 ? String(timeValue) + " " + "Minutes" : "No Timer"
      timerLabel.text = timerLabelText
    }
  }
}
