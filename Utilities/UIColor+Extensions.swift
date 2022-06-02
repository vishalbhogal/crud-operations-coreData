//
//  UIColor+Extensions.swift
//  coredata-demo
//
//  Created by Vishal, Bhogal (B.) on 02/06/22.
//

import Foundation
import UIKit

extension UIColor {
    static var random: UIColor  {
        UIColor(red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 1.0)
    }
    
    static var vistaraYellow: UIColor  {
        UIColor(named: "vistaraYellow")!
    }
    
    static var vistaraPurple: UIColor {
        UIColor(named: "vistaraPurple")!
    }
}
