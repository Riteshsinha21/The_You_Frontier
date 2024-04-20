//
//  UIVIew.swift
//  The_You_Frontier
//
//  Created by Chawtech on 09/01/24.
//

import Foundation
import UIKit


extension UIView {
    
    enum RoundedCorner {
        
        case topTwo
        case bottomTwo
        case leftTwo
        case rightTwo
        
    }
    
    func makeSpecificCornerRound(corners: RoundedCorner,radius: CGFloat){
        switch corners {
        case .bottomTwo:
            
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
            
        case .topTwo:
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            print("")
        case .leftTwo:
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        case .rightTwo:
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            
        }
    }
    
    func cornerRadius()
    {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    func makeRounded()
    {
   
    self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    
    func setViewBorderColor(color:UIColor,width:CGFloat,cornerRadius:CGFloat){
        
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
