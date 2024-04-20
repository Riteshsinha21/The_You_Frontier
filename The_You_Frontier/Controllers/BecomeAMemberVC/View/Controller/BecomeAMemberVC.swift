//
//  BecomeAMemberVC.swift
//  The_You_Frontier
//
//  Created by CTS on 03/01/24.
//

import UIKit

class BecomeAMemberVC: UIViewController {

    @IBOutlet weak var lblMemberTitle: MyBoldLabel!
    @IBOutlet weak var lblMemberDetail: MyRegularLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let text = "Become a member of the You Frontier with this $50 / month subscription. By becoming a member, you will get broad access to our space on a flexible basis. You will receive free or discounted access to our events, and you will even get the opportunity to set up events of your own in our space. You will receive the opportunity to pursue your passions, make new friends, and build your own future."
        
        let attributedText = NSMutableAttributedString.getAttributedString(fromString: text)
        attributedText.apply(color:.bgColor, subString: "$50 / month")

        lblMemberDetail.attributedText = attributedText
       
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        popViewController()
    }
    
    @IBAction func beomeMemberActionBtn(_ sender: UIButton) {
        if let url = URL(string:BaseUrl.becomeMemberUrl ) {
            UIApplication.shared.open(url)
        }
    }


}


extension NSMutableAttributedString {
    
    class func getAttributedString(fromString string: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string)
    }
    
    func apply(attribute: [NSAttributedString.Key: Any], subString: String)  {
        if let range = self.string.range(of: subString) {
            self.apply(attribute: attribute, onRange: NSRange(range, in: self.string))
        }
    }
    
    func apply(attribute: [NSAttributedString.Key: Any], onRange range: NSRange) {
        if range.location != NSNotFound {
            self.setAttributes(attribute, range: range)
        }
    }
    
    // Apply color on substring
     func apply(color: UIColor, subString: String) {
       
       if let range = self.string.range(of: subString) {
         self.apply(color: color, onRange: NSRange(range, in:self.string))
       }
     }
     
     // Apply color on given range
     func apply(color: UIColor, onRange: NSRange) {
       self.addAttributes([NSAttributedString.Key.foregroundColor: color],
                          range: onRange)
     }
}
