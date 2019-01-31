//
//  ImaageHelper.swift
//  Tickets
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//


// caches images to memory
// or makes network request to fetch image

import UIKit

// see comments below to see example of using ImageHelper
// also see EventDetailViewController for usage example

final class ImageHelper {
  private init() {}
  
  private static var cache = NSCache<NSString, UIImage>()
  
  static func fetchImageFromCache(imageURLString: String) -> UIImage? {
    var cachedImage: UIImage?
    if let image = cache.object(forKey: imageURLString as NSString) {
      cachedImage = image
    }
    return cachedImage
  }
  
  static func fetchImageFromNetwork(imageURLString: String, completion: @escaping (Error?, UIImage?) -> Void) {
    guard let url = URL(string: imageURLString) else {
      print("bad image url: \(imageURLString)")
      return
    }
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        completion(error, nil)
      } else if let data = data {
        DispatchQueue.global().async {
          let image = UIImage(data: data)
          if let image = image {
            // save the image to cache (memory)
            cache.setObject(image, forKey: imageURLString as NSString)
            DispatchQueue.main.async {
              completion(nil, image)
            }
          }
        }
      }
    }
    task.resume()
  }
}


// ================= Example of using ImageHelper
/*
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
}*/
