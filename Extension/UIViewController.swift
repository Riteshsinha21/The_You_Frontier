//
//  UIViewController.swift
//  The_You_Frontier
//
//  Created by Chawtech on 10/01/24.
//

import Foundation
import UIKit

extension UIViewController{
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func pushToVC(_ vc: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func ShowAlert(message: String, title: String = TYF_AlertText.alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-150, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.darkGray
        toastLabel.textColor = .white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

//MARK:- Activity indicator view

extension UIViewController {
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        activityIndicator.color = UIColor.bgColor
        
//        activityIndicator.backgroundColor = UIColor.lightGray
//        activityIndicator.alpha = 0.6
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
      //  activityIndicator.style = .UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        
        activityIndicator.tag = 100 // 100 for example

        // before adding it, you need to check if it is already has been added:
        for subview in view.subviews {
            if subview.tag == 100 {
                print("already added")
                return
            }
        }

        view.addSubview(activityIndicator)
    }

    func hideActivityIndicator() {
        let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()

        // I think you forgot to remove it?
        activityIndicator?.removeFromSuperview()

        //UIApplication.shared.endIgnoringInteractionEvents()
    }
}
