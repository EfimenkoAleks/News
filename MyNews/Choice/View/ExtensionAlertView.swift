//
//  ExtensionAlertView.swift
//  MyNews
//
//  Created by user on 19.10.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftEntryKit

extension AlertView {
    
    func createElement() {
        addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        
        addSubview(okButton)
        okButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -80).isActive = true
        okButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(cancelButton)
        cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 80).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: okButton.bottomAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc func ok(_ sender: Any) {
      let url = URL(string: "App-Prefs:root=WIFI")
        if let url = url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        SwiftEntryKit.dismiss()
    }
    
    @objc func cancel(_ sender: Any) {
        SwiftEntryKit.dismiss()
    }
}
