//
//  Extension.swift
//  The_You_Frontier
//
//  Created by Chawtech on 22/12/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
