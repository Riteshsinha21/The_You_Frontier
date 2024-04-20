//
//  NewsDetailVC.swift
//  The_You_Frontier
//
//  Created by Chawtech on 13/02/24.
//

import UIKit
import SDWebImage

class NewsDetailVC: UIViewController {

    var newsTitle = ""
    var newsDiscription = ""
    var newsImageUrl : URL?
    
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var lblDiscription: MyRegularLabel!
    @IBOutlet weak var lblTitle: MyRegularLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = newsTitle
        lblDiscription.text = newsDiscription
        newsImage.sd_setImage(with: newsImageUrl, placeholderImage: UIImage(named: "Mask group-4"))

    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        popViewController()
    }
}
