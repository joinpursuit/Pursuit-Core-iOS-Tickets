//
//  DataPersistenceManager.swift
//  Tickets
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//


// path to documents directory

import Foundation

final class DataPersistenceManager {
  private init() {}
  
  // to get the path to the documents directory
  static func documentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }

  // to create a path with a filename to the documents directory
  static func filenameFromDoucmentsDirectory(filename: String) -> URL {
    return documentsDirectory().appendingPathComponent(filename)
  }
  
}



