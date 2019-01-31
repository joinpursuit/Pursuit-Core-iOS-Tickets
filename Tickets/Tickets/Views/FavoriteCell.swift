//
//  FavoriteCell.swift
//  Tickets
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
  
  public lazy var dayLabel: UILabel = {
    let label = UILabel()
    label.text = "MON"
    label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
    return label
  }()
  
  public lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.text = "Jan 30"
    return label
  }()
  
  private lazy var dateDividingLine: UIView = {
    let view = UIView()
    view.backgroundColor = .lightGray
    return view
  }()
  
  public lazy var eventName: UILabel = {
    let label = UILabel()
    label.text = "Event Name"
    return label
  }()
  
  public lazy var venueLabel: UILabel = {
    let label = UILabel()
    label.text = "Blue Man Theatre"
    return label
  }()
  
  public lazy var eventImage: UIImageView = {
    let iv = UIImageView(image: UIImage(named: "pursuit-log"))
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupViews()
    eventImage.layer.cornerRadius = eventImage.bounds.width / 2.0
  }
  
  public func configureCell(favoriteEvent: FavoriteEvent) {
    eventName.text = favoriteEvent.name
    dayLabel.text = favoriteEvent.getDay
    dateLabel.text = favoriteEvent.getDate
    eventName.text = favoriteEvent.name
    venueLabel.text = favoriteEvent.getTime + " - " + favoriteEvent.venue
    
    if let imageData = favoriteEvent.imageData {
      DispatchQueue.global().async {
        let image = UIImage(data: imageData)
        DispatchQueue.main.async {
          self.eventImage.image = image
        }
      }
    }
  }
}

extension FavoriteCell {
  private func setupViews() {
    setupDayLabel()
    setupDateDividingLine()
    setupDateLabel()
    setupEventImage()
    setupEventImage()
    setupEventNameLabel()
    setupVenueLabel()
  }
  
  private func setupDayLabel() {
    addSubview(dayLabel)
    dayLabel.translatesAutoresizingMaskIntoConstraints = false
    dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
  }
  
  private func setupDateLabel() {
    addSubview(dateLabel)
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 8).isActive = true
    dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
  }
  
  private func setupDateDividingLine() {
    addSubview(dateDividingLine)
    dateDividingLine.translatesAutoresizingMaskIntoConstraints = false
    dateDividingLine.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    dateDividingLine.widthAnchor.constraint(equalToConstant: 2).isActive = true
    dateDividingLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bounds.width * 0.25).isActive = true
    dateDividingLine.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
  }
  
  private func setupEventNameLabel() {
    addSubview(eventName)
    eventName.translatesAutoresizingMaskIntoConstraints = false
    eventName.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    eventName.leadingAnchor.constraint(equalTo: dateDividingLine.trailingAnchor, constant: 16).isActive = true
    eventName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
  }
  
  private func setupVenueLabel() {
    addSubview(venueLabel)
    venueLabel.translatesAutoresizingMaskIntoConstraints = false
    venueLabel.topAnchor.constraint(equalTo: eventName.bottomAnchor, constant: 8).isActive = true
    venueLabel.leadingAnchor.constraint(equalTo: dateDividingLine.trailingAnchor, constant: 16).isActive = true
    venueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
  }
  
  private func setupEventImage() {
    addSubview(eventImage)
    eventImage.translatesAutoresizingMaskIntoConstraints = false
    eventImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    eventImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
    eventImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    eventImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
  }
}
