//
//  TicketmasterAPIClient.swift
//  Tickets
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

// makes request to ticketmast api 

import Foundation

final class TicketmasterAPIClient {
  static func searchEvents(keyword: String, isZipcode: Bool, completion: @escaping (Error?, [Event]?) -> Void) {
    var endpointURLString = ""
    if isZipcode {
      endpointURLString = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=\(SecretKeys.TicketmasterAPIKey)&postalCode=\(keyword)&radius=200&unit=miles"
    } else {
      guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
        print("encoding keyword error: \(keyword)")
        return
      }
      endpointURLString = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=\(SecretKeys.TicketmasterAPIKey)&city=\(encodedKeyword)&radius=200&unit=miles"
    }
    guard let url = URL(string: endpointURLString) else {
      print("bad url string: \(endpointURLString)")
      return
    }
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        print("error: \(error)")
        completion(error, nil)
      } else if let data = data {
        do {
          let eventData = try JSONDecoder().decode(EventsData.self, from: data)
          let events = eventData._embedded?.events
          completion(nil, events)
        } catch {
          print("json decoding error: \(error)")
          completion(error, nil)
        }
      }
    }
    task.resume()
  }
}
