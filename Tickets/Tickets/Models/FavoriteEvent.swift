//
//  FavoriteEvent.swift
//  Tickets
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

// for saving to documents directory

struct FavoriteEvent: Codable {
  let name: String
  let dateTime: String?
  let imageData: Data?
  let id: String
  let venue: String
  
  public var getDay: String {
    var day = "no day"
    if let value = dateTime?.formatISODateString(dateFormat: "EEE") {
      day = value.uppercased()
    }
    return day
  }
  
  public var getDate: String {
    var date = "no date"
    if let value = dateTime?.formatISODateString(dateFormat: "MMM d") {
      date = value.uppercased()
    }
    return date
  }
  
  public var getTime: String {
    var time = "no time"
    if let value = dateTime?.formatISODateString(dateFormat: "h:mm a") {
      time = value.uppercased()
    }
    return time
  }
  
//  public var getVenue: String {
//    return _embedded?.venues.first?.name ?? "no venue name"
//  }
}
