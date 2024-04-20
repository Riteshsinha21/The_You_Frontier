//
//  SideMenuVC.swift
//  The_You_Frontier
//
//  Created by CTS on 02/01/24.
//


import UIKit
import SideMenu

class SideMenuVC: UIViewController {
    var menu: SideMenuNavigationController?
    
    @IBOutlet weak var ReadMoreBtn: UIButton!
    
    @IBOutlet weak var weOfferLbl: UILabel!
    
    @IBOutlet weak var WeOfferReadMoreBtn: UIButton!
    
    @IBOutlet weak var ourMissionLbl: UILabel!
    
    @IBOutlet weak var dottedViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var dottedView :UIView!
    
    @IBOutlet weak var PhysicalSocialNetShowMoreBtn: UIButton!
    
    @IBOutlet weak var physicalSocialNetworkLbl: UILabel!
    
    @IBOutlet weak var chanceShowMoreBtn: UIButton!
    
    @IBOutlet weak var chanceLbl: UILabel!
    
    let maxNumberOfLines = 3
    var isExpanded = [false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kUserDefaults.set("Home", forKey: AppKeys.tabName)
        menu = SideMenuNavigationController(rootViewController: SideMenuListVC())
        menu?.presentationStyle = .menuSlideIn
        menu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.menuWidth = 300
        
        ourMissionLbl.numberOfLines = maxNumberOfLines
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        ourMissionLbl.addGestureRecognizer(tapGesture)
        ReadMoreBtn.isHidden = ourMissionLbl.numberOfLines >= ourMissionLbl.calculateMaxLines()
        
        
        weOfferLbl.numberOfLines = maxNumberOfLines
        let tapGestureWeOffer = UITapGestureRecognizer(target: self, action: #selector(weOfferlabelTapped))
        weOfferLbl.addGestureRecognizer(tapGestureWeOffer)
        WeOfferReadMoreBtn.isHidden = weOfferLbl.numberOfLines >= weOfferLbl.calculateMaxLines()

    }
    
    @IBAction func onClickMenuBtn(_ sender: Any) {
        present(menu!,animated: true, completion: nil )
    }
    
    @IBAction func OnClickReadMore(_ sender: Any) {
        
        
        isExpanded[0].toggle()
        if isExpanded[0] {
            ourMissionLbl.numberOfLines = 0  // Display all lines
        } else {
            ourMissionLbl.numberOfLines = maxNumberOfLines
        }
        let buttonTitle = isExpanded[0] ? "Show Less" : "Show More"
        ReadMoreBtn.setTitle(buttonTitle, for: .normal)
    }
    
    @IBAction func weOfferShowMoreBtn(_ sender: Any) {
        isExpanded[1].toggle()
        if isExpanded[1] {
            weOfferLbl.numberOfLines = 0

        } else {
            weOfferLbl.numberOfLines = maxNumberOfLines
        }
        
        let buttonTitle = isExpanded[1] ? "Show Less" : "Show More"
        WeOfferReadMoreBtn.setTitle(buttonTitle, for: .normal)
    }
    
    
    @IBAction func PhySicalSocialNetworkShowMoreBtn(_ sender: Any) {
        isExpanded[2].toggle()
        if isExpanded[2] {
            physicalSocialNetworkLbl.numberOfLines = 0
        } else {
            physicalSocialNetworkLbl.numberOfLines = maxNumberOfLines
        }
        let buttonTitle = isExpanded[2] ? "Show Less" : "Show More"
        PhysicalSocialNetShowMoreBtn.setTitle(buttonTitle, for: .normal)
    }
    
    @IBAction func onClickChanceShowMoreBtn(_ sender: Any) {
        isExpanded[3].toggle()
        if isExpanded[3] {
            chanceLbl.numberOfLines = 0
        } else {
            chanceLbl.numberOfLines = maxNumberOfLines
        }
        let buttonTitle = isExpanded[3] ? "Show Less" : "Show More"
        chanceShowMoreBtn.setTitle(buttonTitle, for: .normal)
    }
    
    
    
    @IBAction func onClickBecomeAmemberBtn(_ sender: Any) {
        ReadMoreBtn.setTitleColor(UIColor.white, for: .normal)
        if let url = URL(string:BaseUrl.becomeMemberUrl ) {
            UIApplication.shared.open(url)
        }
    }
    
    
    @objc func labelTapped() {
        OnClickReadMore(ReadMoreBtn)
    }
    
    @objc func weOfferlabelTapped() {
        weOfferShowMoreBtn(WeOfferReadMoreBtn)
        
    }
    
    @objc func PhySicalSocialNetworklabelTapped() {
        PhySicalSocialNetworkShowMoreBtn(PhysicalSocialNetShowMoreBtn)
    }
    
    @objc func ChancelabelTapped() {
        onClickChanceShowMoreBtn(chanceShowMoreBtn)
    }
    

}

extension UILabel {
    func calculateMaxLines() -> Int {
        guard let font = self.font else {
            return 0
        }
        
        let maxSize = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let textHeight = self.text?.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).height ?? 0
        
        let lineHeight = font.lineHeight
        let numberOfLines = Int(textHeight / lineHeight)
        
        return numberOfLines
    }
}



class DashedLinesView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Create a path for the dashed line
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width / 2, y: 0))
        path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height))

        // Create a shape layer
        let dashedLineLayer = CAShapeLayer()
        dashedLineLayer.strokeColor = UIColor.bgColor.cgColor
        dashedLineLayer.lineWidth = 1.0
        dashedLineLayer.lineDashPattern = [4, 2] // Adjust the dash and gap lengths as needed
        dashedLineLayer.path = path.cgPath

        // Add the shape layer to the view's layer
        layer.addSublayer(dashedLineLayer)
    }
}
