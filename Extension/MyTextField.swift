//
//  CustomLocalizedTextField.swift
//  The_You_Frontier
//
//  Created by Chawtech on 26/12/23.
//

import UIKit

class MyTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        layer.borderWidth = 0.7
        font = FontSize.regular
        textColor = UIColor.white

         attributedPlaceholder = NSAttributedString(string:placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0/255, green: 205/255, blue: 217/255, alpha: 1)])

        layer.borderColor = UIColor.bgColor.cgColor
        layer.masksToBounds = true
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height:frame.height))
        leftViewMode = .always
       
    }
  
}

