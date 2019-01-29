//
//  CircleImageView.swift
//  CurrencyTestApp
//
//  Created by makeev on 29.01.2019.
//

import Foundation
import UIKit

class CircleImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width/2
    }
    
}
