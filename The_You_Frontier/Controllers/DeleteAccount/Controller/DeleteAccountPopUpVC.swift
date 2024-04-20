//
//  DeleteAccountPopUpVC.swift
//  The_You_Frontier
//
//  Created by CTS on 18/01/24.
//

import UIKit

class DeleteAccountPopUpVC: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var PpopupView: UIView!
    
    @IBOutlet weak var cancleBtn: UIStackView!
    
    @IBOutlet weak var yesBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PpopupView.setViewBorderColor(color: UIColor.bgColor, width: 0.8, cornerRadius: 8)
        cancleBtn.layer.cornerRadius = 5
        yesBtn.layer.cornerRadius = 5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

        mainView.addGestureRecognizer(tap)

        mainView.isUserInteractionEnabled = true

        
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
      }

    
    @IBAction func onClickCancleBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func onClickYesBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
