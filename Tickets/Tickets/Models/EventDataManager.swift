//
//  EventDataManager.swift
//  Tickets
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//


// data manager handles saving favorite events to the documents directrory

import Foundation

final class EventDataManager {
  private init() {}
  
  private static let filename = "FavoriteEvents.plist"
  
  static public func fetchFavoriteEventsFromDocumentsDirectory() -> [FavoriteEvent] {
    var events = [FavoriteEvent]()
    let path = DataPersistenceManager.filenameFromDoucmentsDirectory(filename: filename).path
    if FileManager.default.fileExists(atPath: path) {
      if let data = FileManager.default.contents(atPath: path) {
        do {
          events = try PropertyListDecoder().decode([FavoriteEvent].self, from: data)
        } catch {
          print("property list decoding error: \(error)")
        }
      } else {
        print("data is nil")
      }
    } else {
      print("\(filename) does not exist")
    }
    return events
  }
  
  static public func saveToDocumentDirectory(newFavoriteEvent: FavoriteEvent) -> (success: Bool, error: Error?) {
    var favoriteEvents = fetchFavoriteEventsFromDocumentsDirectory()
    favoriteEvents.append(newFavoriteEvent)
    let path = DataPersistenceManager.filenameFromDoucmentsDirectory(filename: filename)
    do {
      let data = try PropertyListEncoder().encode(favoriteEvents)
      try data.write(to: path, options: Data.WritingOptions.atomic)
    } catch {
      print("property list encoding error: \(error)")
      return (false, error)
    }
    return (true, nil)
  }
  
  static func delete(favoriteEvent: FavoriteEvent, atIndex index: Int) {
    // get current favorite evnets and remove favorite from index
    var favoriteEvents = fetchFavoriteEventsFromDocumentsDirectory()
    favoriteEvents.remove(at: index)
    
    // save change to documents directory
    let path = DataPersistenceManager.filenameFromDoucmentsDirectory(filename: filename)
    do {
      let data = try PropertyListEncoder().encode(favoriteEvents)
      try data.write(to: path, options: Data.WritingOptions.atomic)
    } catch {
      print("property list encoding error: \(error)")
    }
  }
  
  static public func isFavorite(id: String) -> Bool {
    let index = fetchFavoriteEventsFromDocumentsDirectory().index { $0.id == id }
    var found = false
    if let _ = index {
      found = true
    }
    return found
  }
  
  
}
