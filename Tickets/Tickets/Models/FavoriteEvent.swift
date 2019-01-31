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
}
