//
//  SideMenuListVC.swift
//  The_You_Frontier
//
//  Created by CTS on 02/01/24.
//

import UIKit
import SideMenu
class SideMenuListVC: UITableViewController {
    
    let data = ["Home","Change password", "Become a member", "Message to Pioneers&members","Privacy policy","T & C","Delete Account","Logout"]
    
    let sideMeniImages =
    ["home 1","changepassword","Becomeamember","message","privacypolicy","t&c","DeleteAccont","logout"]
    
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      self.tableView.sectionHeaderHeight = 50
        setUpHeaderView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.clipsToBounds = true
        tableView.makeSpecificCornerRound(corners: .rightTwo, radius: 50)
       
        
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        cell.imageView?.image = UIImage(named: sideMeniImages[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 100
    }
    
    func setUpHeaderView(){
         let headerView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: self.tableView.frame.width,
                                               height: 100))
         headerView.backgroundColor = .black
         self.tableView.tableHeaderView = headerView
        // Add image
         var imageView : UIImageView
         imageView  = UIImageView(frame:CGRect(x: 10, y: 10, width: 60, height: 60))
        
//   if kUserDefaults.value(forKey: AppKeys.profile) != nil {
//             if  let userImage = kUserDefaults.value(forKey: AppKeys.profile) {
//                 imageView.sd_setImage(with: URL(string:userImage as! String), placeholderImage: UIImage(named: "user"))
//
//             }
//         }else{
//         imageView.image  = UIImage(named: "user")
//
//         }
        
         imageView.layer.masksToBounds = false
         imageView.layer.cornerRadius = imageView.frame.height/2
         imageView.image  = UIImage(systemName: "person.circle.fill")
         imageView.image?.withTintColor(.white)
         imageView.backgroundColor = .white
         imageView.clipsToBounds = true
         headerView.addSubview(imageView)
         
         let name:UILabel = UILabel(frame: CGRect(x: imageView.frame.width + 120, y: imageView.frame.height - 30, width: headerView.frame.width - 95, height: 30))
         name.textAlignment = .left
//       name.font = FontSize.size20
         name.textColor = .white
        var userName = kUserDefaults.value(forKey: AppKeys.name) as? String
        name.text = userName?.capitalized
         headerView.addSubview(name)
         let attrs = [
             NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0),
           
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
         let attributedString = NSMutableAttributedString(string:"")

    let viewProfileBtn:UIButton = UIButton(frame: CGRect(x: imageView.frame.width + 23, y:  imageView.frame.height - 20, width: headerView.frame.width - 95, height: 18))

//         let buttonTitleStr = NSMutableAttributedString(string:LTYText.textDrower_ViewProfile.localized(), attributes:attrs)
//         attributedString.append(buttonTitleStr)
//         viewProfileBtn.setAttributedTitle(attributedString, for: .normal)
//         viewProfileBtn.contentHorizontalAlignment = .left
//         viewProfileBtn.addTarget(self, action: #selector(viewProileButton(_: )), for: UIControl.Event.touchUpInside)
//         headerView.addSubview(viewProfileBtn)

         let label:UILabel = UILabel(frame: CGRect(x: 0, y: 99.5, width: tableView.frame.width, height: 0.5))
         label.backgroundColor = .black
         headerView.addSubview(label)
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedCell = tableView.cellForRow(at: indexPath)
        switch indexPath.row {
        case 0:
            
            let tabType = kUserDefaults.value(forKey: AppKeys.tabName)
            if tabType as! String == "ProfileTab"{
                TYF_AppDelegate.switchToHomeVC()
            }else{
                dismiss(animated: true)
            }
            
        case 1:
            let storyBoard = UIStoryboard(name: "MapStoryboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            
            let storyBoard = UIStoryboard(name: "MapStoryboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "BecomeAMemberVC") as! BecomeAMemberVC
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            let storyBoard = UIStoryboard(name: "MapStoryboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MessageToPoineers_MembersVC") as! MessageToPoineers_MembersVC
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            let storyBoard = UIStoryboard(name: "MapStoryboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let storyBoard = UIStoryboard(name: "MapStoryboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "Terms_ConditionsVC") as! Terms_ConditionsVC
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            let storyBoard = UIStoryboard(name: "MapStoryboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "DeleteAccountPopUpVC") as! DeleteAccountPopUpVC
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(vc, animated: true)
            
        case 7:
            
            let storyBoard = UIStoryboard(name: "MapStoryboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LogOutPopUpVC") as! LogOutPopUpVC
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
           // self.navigationController?.pushViewController(vc, animated: true)

            self.navigationController?.present(vc, animated: true)
    
            
        default:
            break
        }
    }
   
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
