//
//  ShowEventImagesVC.swift
//  The_You_Frontier
//
//  Created by Chawtech on 01/02/24.
//

import UIKit

class ShowEventImagesVC: UIViewController {
    
    @IBOutlet weak var lblTitle: MyBoldLabel!
    @IBOutlet var collectionView: UICollectionView!
    
    var videosList = [String]()//["img1","img2","img3","img4","img1","img2","img3","img4"]
    var videoTitle = ""
    var itemCount = 4
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = videoTitle
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
