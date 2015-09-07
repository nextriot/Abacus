//
//  GameSearchTableViewController.swift
//  Abacus
//
//  Created by Kyle Gillen on 03/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import UIKit

class GameSearchTableViewController: UITableViewController {
  
  let cardGames = ["Canasta", "Poker", "Bridge"]
  var filteredData = [String]()
  var resultsSearchController: UISearchController!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      // prevents animation when focussing on UISearchBar
      edgesForExtendedLayout = UIRectEdge.None
      
      self.resultsSearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.dimsBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.searchBarStyle = UISearchBarStyle.Minimal
        controller.searchBar.tintColor = Constants.Colors.Fuchsia
        controller.searchBar.placeholder = "Search for games..."
        controller.searchBar.backgroundColor = .whiteColor()
        
        // bottom border for search bar
        let bottomBorder = UIView(frame: CGRect(x: 0, y: CGRectGetHeight(controller.searchBar.frame) - 0.5, width: CGRectGetWidth(controller.searchBar.frame), height: 0.5))
        bottomBorder.backgroundColor = Constants.Colors.MediumGrey
        controller.searchBar.layer.addSublayer(bottomBorder.layer)
        
        controller.delegate = self
        return controller
      })()
      
      self.tableView.tableHeaderView = resultsSearchController.searchBar
      self.tableView.tableFooterView = UIView(frame: CGRectZero)
      self.tableView.contentInset = UIEdgeInsetsZero
      self.tableView.separatorColor = Constants.Colors.MediumGrey
      self.tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
}

// MARK: - Table view data source

extension GameSearchTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  //
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    if self.resultsSearchController.active {
      return filteredData.count
    } else {
      return cardGames.count
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("GameSearchResultCell", forIndexPath: indexPath)
    return cell
  }
}

// MARK: - UITableView Delegate Methods
extension GameSearchTableViewController {
  
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    
    cell.textLabel?.textColor = Constants.Colors.DarkGrey
    cell.layoutMargins.left = 0.0
    cell.preservesSuperviewLayoutMargins = false
    cell.textLabel?.font = UIFont.systemFontOfSize(16.0)
    
    let cellSelectedBg = UIView(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(cell.frame), height: CGRectGetHeight(cell.frame)))
    cellSelectedBg.backgroundColor = Constants.Colors.LightGrey
    cell.selectedBackgroundView = cellSelectedBg
    
    if self.resultsSearchController.active {
      cell.textLabel?.text = filteredData[indexPath.row]
    } else {
      cell.textLabel?.text = cardGames[indexPath.row]
    }
  }
  
}

// MARK: UISearchDisplay Delegate Methods

extension GameSearchTableViewController: UISearchControllerDelegate {
  func didPresentSearchController(searchController: UISearchController) {
    self.view.superview?.frame = CGRect(x: 0, y: 0, width: CGRectGetWidth(self.view.frame), height: CGRectGetHeight(self.view.superview!.superview!.frame))
  }
  
  func didDismissSearchController(searchController: UISearchController) {
    self.view.superview?.frame = CGRect(x: 0, y: 0, width: CGRectGetWidth(self.view.frame), height: CGRectGetHeight(searchController.searchBar.frame))
  }
}

extension GameSearchTableViewController: UISearchResultsUpdating {
  
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    filteredData.removeAll(keepCapacity: false)
    
    if searchController.searchBar.text != "" {
      let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
      let array = (cardGames as NSArray).filteredArrayUsingPredicate(searchPredicate)
      filteredData = array as! [String]
    } else {
      filteredData = cardGames
    }
    
    
    self.tableView.reloadData()
  }
  
//  func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
//    self.filterContentForSearchText(searchString!)
//    return true
//  }
}
