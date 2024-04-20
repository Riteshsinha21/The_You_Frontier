//
//  UIColor.swift
//  The_You_Frontier
//
//  Created by Chawtech on 26/12/23.
//

import Foundation

import UIKit


extension UIColor {
    static var bgColor: UIColor {
        return UIColor.color(name: "bgColor")
    }
    static var whiteColor: UIColor {
        return UIColor.color(name: "whiteColor")
    }
    static var tabUnselectedColor: UIColor {
        return UIColor.color(name: "tabUnselectedColor")
    }
  static var blackColor: UIColor {
        return UIColor.color(name: "blackColor")
    }

    private static func color(name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            return .black
        }
        return color
    }
}
