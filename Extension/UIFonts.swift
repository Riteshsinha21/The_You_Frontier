//
//  UIFonts.swift
//  The_You_Frontier
//
//  Created by Chawtech on 26/12/23.
//

import Foundation
import UIKit

struct FontSize {

    static let regular = UIFont(name:"EkMukta-Regular",size:16)
    static let medium = UIFont(name:"EkMukta-Medium",size:20)
    static let bold = UIFont(name:"EkMukta-Bold",size:24)
  
}

struct DroverHeight {
    static let haveNotch = CGFloat(80)
    static let dontHaveNotch = CGFloat(60)

}


extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}





