//
//  CustomLocalizedLabel.swift
//  The_You_Frontier
//
//  Created by Chawtech on 26/12/23.
//


import UIKit


class MyBoldLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        font = FontSize.bold
        //text = text?.localized()
    }
    
}

class MyRegularLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        font = FontSize.regular
        //text = text?.localized()
    }
    
}

class MyMediumLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        font = FontSize.medium
        //text = text?.localized()
    }
    
}
