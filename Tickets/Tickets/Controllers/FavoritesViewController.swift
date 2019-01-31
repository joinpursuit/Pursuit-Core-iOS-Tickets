//
//  FavoritesViewController.swift
//  Tickets
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

// shows favorite events saved

import UIKit

class FavoritesViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private var favoriteEvents = [FavoriteEvent]() {
    didSet {
      tableView.reloadData()
      navigationItem.title = "Favorites (\(favoriteEvents.count))"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    favoriteEvents = EventDataManager.fetchFavoriteEventsFromDocumentsDirectory()
    print("found \(favoriteEvents.count) favorite events")
  }
  
}

extension FavoritesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoriteEvents.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell else {
      fatalError("FavoriteCell is nil")
    }
    let favoriteEvent = favoriteEvents[indexPath.row]
    cell.configureCell(favoriteEvent: favoriteEvent)
    return cell
  }
}

extension FavoritesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alert in
      self.deleteFavorite(indexPath: indexPath)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(deleteAction)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
  }
  
  private func deleteFavorite(indexPath: IndexPath) {
    let favoriteEvent = favoriteEvents[indexPath.row]
    EventDataManager.delete(favoriteEvent: favoriteEvent, atIndex: indexPath.row)
    favoriteEvents = EventDataManager.fetchFavoriteEventsFromDocumentsDirectory()
  }
}

