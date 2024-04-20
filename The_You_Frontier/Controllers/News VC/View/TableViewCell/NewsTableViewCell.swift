//
//  NewsTableViewCell.swift
//  The_You_Frontier
//
//  Created by CTS on 11/01/24.
//

import UIKit

class NewsTableViewCell: UITableViewCell , Reusable{

    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellHeaderLbl: UILabel!
    
    
    @IBOutlet weak var cellTitleLbl: UILabel!
    
    
    @IBOutlet weak var cellDescriptionLbl: UILabel!
    
    
    
    @IBOutlet weak var cellIImgView: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        cellView.setViewBorderColor(color: UIColor.bgColor, width: 1,cornerRadius: 15)
       
    }

   
    
}
