//
//  EventDetailView.swift
//  Tickets
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class EventDetailView: UIView {
  
  public lazy var eventImageView: UIImageView = {
    let iv = UIImageView(image: UIImage(named: "placeholder-image"))
    return iv
  }()
  
  public lazy var eventName: UILabel = {
    let label = UILabel()
    label.text = "Event Name"
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    setupViews()
  }
}

extension EventDetailView {
  private func setupViews() {
    setupEventImageView()
    setupEventName()
  }
  
  private func setupEventImageView() {
    addSubview(eventImageView)
    eventImageView.translatesAutoresizingMaskIntoConstraints = false
    eventImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    eventImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    eventImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.50).isActive = true
  }
  
  private func setupEventName() {
    
  }
}
