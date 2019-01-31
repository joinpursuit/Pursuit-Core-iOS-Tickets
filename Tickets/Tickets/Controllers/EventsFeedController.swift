//
//  EventsFeedController.swift
//  Tickets
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class EventsFeedController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView! 
  
  private var defaultSearch = "10023" {
    didSet {
      searchEvents()
    }
  }
  private var isZipcode = true
  
  private var events = [Event]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar()
    tableView.dataSource = self
    tableView.delegate = self
    searchEvents()
  }
  
  private func searchEvents() {
    isZipcode = true
    for char in defaultSearch {
      if Int(String(char)) == nil { //
        isZipcode = false
        break
      }
    }
    TicketmasterAPIClient.searchEvents(keyword: defaultSearch, isZipcode: isZipcode) { (error, events) in
      if let error = error {
        print("searchEvents error: \(error)")
      } else if let events = events {
        self.events = events
      }
    }
  }
  
  private func configureNavBar() {
    navigationItem.title = "Events"
    
    // RETRIEVE / RESTORE / FETCH / GET BACK VALUE FROM USER DEFAULTS
    if let defaultSearch = UserDefaults.standard.object(forKey: UserDefaultsKeys.DefaultSearchKey) as? String {
      // WE HAVE A VALUE (E.G THE ZIP CODE OR CITY NAME ENTERED) FROM USER DEFAULTS
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: defaultSearch, style: .plain, target: self, action: #selector(updateDefaultSearch))
      self.defaultSearch = defaultSearch
    } else {
      // WE DID NOT FIND A VALUE FOR THE GIVEN KEY
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: defaultSearch, style: .plain, target: self, action: #selector(updateDefaultSearch))
    }
  }
  
  // .alert presents dialog box
  // .actionSheet present modal view from the bottom
  @objc private func updateDefaultSearch() {
    let alertController = UIAlertController(title: "Default Search", message: "Please enter a default zip code e.g 10023 or city name e.g Miami", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    let submitAction = UIAlertAction(title: "Submit", style: .default) { alert in
      // access textfield from the alertController
      guard let defaultSearch = alertController.textFields?.first?.text else {
        print("alertController textfield is nil")
        return
      }
      // change the right bar button item title to the default seach name
      self.navigationItem.rightBarButtonItem?.title = defaultSearch
      
      // updated default search
      self.defaultSearch = defaultSearch
      
      // add new default search to user defaults
      // user defaults is a key/value pair structure similar to a dictionary
      /// STORE / SAVE / PERSIST TO USER DEFAULTS
      // can only save propperty list objects, e.g Data, String, Bool, Int
      UserDefaults.standard.set(defaultSearch, forKey: UserDefaultsKeys.DefaultSearchKey)
      
      
      // TODO: query to Ticketmaster API for event searches
    }
    alertController.addTextField { (textfield) in
      textfield.placeholder = "enter zip code or city name"
      textfield.textAlignment = .center
    }
    alertController.addAction(cancelAction)
    alertController.addAction(submitAction)
    present(alertController, animated: true)
  }
}

extension EventsFeedController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return events.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
    let event = events[indexPath.row]
    cell.textLabel?.text = event.name
    return cell
  }
}

extension EventsFeedController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let event = events[indexPath.row]
    guard let eventDetailVC = storyboard?.instantiateViewController(withIdentifier: "EventDetailViewController") as? EventDetailViewController else {
      print("EventDetailViewController is nil")
      return
    }
    eventDetailVC.event = event
    navigationController?.pushViewController(eventDetailVC, animated: true)
  }
}
