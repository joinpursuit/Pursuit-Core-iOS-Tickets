//
//  Event.swift
//  Tickets
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct EventsData: Codable {
  struct Embedded: Codable {
    let events: [Event]
  }
  let _embedded: Embedded?
}

struct Event: Codable {
  let name: String
  let type: String
  let id: String
  let url: URL
  struct ImageInfo: Codable {
    let ratio: String
    let url: URL
    let width: Int
    let height: Int
  }
  let images: [ImageInfo]
  struct DateInfo: Codable {
    struct Start: Codable {
      let localDate: String
      let localTime: String?
      let dateTime: String?
    }
    let start: Start
  }
  let dates: DateInfo
  
  struct Embedded: Codable {
    struct Venue: Codable {
      let name: String
      let type: String
      
      //let city: City
    }
    let venues: [Venue]
  }
  let _embedded: Embedded?
  
  var isFavorite: Bool?
  
  public var getDay: String {
    var day = "no day"
    if let value = dates.start.dateTime?.formatISODateString(dateFormat: "EEE") {
      day = value.uppercased()
    }
    return day
  }
  
  public var getDate: String {
    var date = "no date"
    if let value = dates.start.dateTime?.formatISODateString(dateFormat: "MMM d") {
      date = value.uppercased()
    }
    return date
  }
  
  public var getTime: String {
    var time = "no time"
    if let value = dates.start.dateTime?.formatISODateString(dateFormat: "h:mm a") {
      time = value.uppercased()
    }
    return time
  }
  
  public var getVenue: String {
    return _embedded?.venues.first?.name ?? "no venue name"
  }
}
