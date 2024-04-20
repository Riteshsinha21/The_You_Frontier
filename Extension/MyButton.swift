//
//  CustomLocalizedButton.swift
//  The_You_Frontier
//
//  Created by Chawtech on 26/12/23.
//

import UIKit


class MyButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.font = FontSize.medium
     
       // backgroundColor = UIColor.bgColor
        
        setTitleColor(UIColor.white, for: .normal)
        setBackgroundImage(UIImage(named: "bgButton"), for: .normal)
        layer.cornerRadius = 8
    }
}


