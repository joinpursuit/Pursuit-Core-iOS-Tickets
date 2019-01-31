//
//  EventDetailViewController.swift
//  Tickets
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

//  shows event selected, here we can add an event to favorites

import UIKit

class EventDetailViewController: UIViewController {
  
  @IBOutlet var eventDetailView: EventDetailView!
  
  public var event: Event!
  
  // for saving along with our favorite event
  private var imageData: Data?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar()
    updateUI()
  }
  
  private func configureNavBar() {
    // set navigation bar title
    navigationItem.title = event.name
    
    // setup right bar button item to "Favorite"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(addToFavorite))
  }
  
  private func updateUI() {
    guard let imageURL = event.images.first?.url else {
      print("image url is nil")
      return
    }
    if let image = ImageHelper.fetchImageFromCache(imageURLString: imageURL.absoluteString) {
      eventDetailView.eventImageView.image = image
      imageData = image.jpegData(compressionQuality: 0.5)
    } else {
      ImageHelper.fetchImageFromNetwork(imageURLString: imageURL.absoluteString) { (error, image) in
        if let error = error {
          print("fetchImageFromNetwork - error: \(error)")
        } else if let image = image {
          self.imageData = image.jpegData(compressionQuality: 0.5)
          self.eventDetailView.eventImageView.image = image
        }
      }
    }
  }
  
  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
  
  @objc private func addToFavorite() {
    // don't add duplicates
    guard !EventDataManager.isFavorite(id: event.id) else {
      showAlert(title: "Duplicate", message: "\(event.name) already exist in your favorites")
      return
    }
    
    let venue = event._embedded?.venues.first?.name ?? "no venue"
    let favoriteEvent = FavoriteEvent.init(name: event.name,
                                      dateTime: event.dates.start.dateTime,
                                      imageData: imageData,
                                      id: event.id,
                                      venue: venue)
    let savedStatus = EventDataManager.saveToDocumentDirectory(newFavoriteEvent: favoriteEvent)
    if let error = savedStatus.error {
      showAlert(title: "Saving error", message: "Error saving \(error.localizedDescription)")
    } else {
      showAlert(title: "", message: "\(event.name) saved to favorites")
    }
  }
}
