//
//  EventListTVC.swift
//  The_You_Frontier
//
//  Created by Chawtech on 10/01/24.
//

import UIKit

class EventListTblCell: UITableViewCell ,Reusable {

    @IBOutlet weak var eventBgView: UIView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDetail: UILabel!
    @IBOutlet weak var btnViewEvent: MyButton!
    @IBOutlet weak var eventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        eventImage.layer.cornerRadius = 8
        eventImage.layer.borderColor = UIColor.white.cgColor
        eventImage.layer.borderWidth = 1
        
        eventBgView.setViewBorderColor(color: UIColor.bgColor, width: 1,cornerRadius: 15)
    }


    
}
