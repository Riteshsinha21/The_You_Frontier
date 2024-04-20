//
//  CustomLocalizedTextView.swift
//  The_You_Frontier
//
//  Created by Chawtech on 26/12/23.
//

import UIKit

class MyTextView: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
        layer.borderWidth = 0.7
        font = FontSize.regular
        layer.borderColor = UIColor.bgColor.cgColor
       
        //text = text?.localized()
    }
    
}

