//
//  Event.swift
//  Tickets
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

// coming from the Ticketmaster API 

struct EventData: Codable {
  struct Embedded: Codable {
    let events: [Event]
  }
  let _embedded: Embedded?
}

struct Event: Codable {
  let name: String // save
  let type: String
  let id: String // save
  let url: URL
  struct ImageInfo: Codable {
    let ratio: String
    let url: URL // save
    let width: Int
    let height: Int
  }
  let images: [ImageInfo]
  struct DateInfo: Codable {
    struct Start: Codable {
      let localDate: String
      let localTime: String?
      let dateTime: String? // save
    }
    let start: Start
  }
  let dates: DateInfo
}
