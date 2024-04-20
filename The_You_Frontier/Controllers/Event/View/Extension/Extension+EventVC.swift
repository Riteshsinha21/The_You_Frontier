//
//  Extension+EventVC.swift
//  The_You_Frontier
//
//  Created by Chawtech on 10/01/24.
//

import Foundation
import UIKit

extension EventVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(EventListTblCell.self, for: indexPath)

        let data = eventListData[indexPath.row]
        
        cell.eventTitle.text = data.name ?? ""
        cell.eventDetail.text = data.description ?? ""
        
        let eventTimeDetail = "\(data.event_date ?? "") \(data.event_time ?? "")"
        
        
        let myDate = eventTimeDetail
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: myDate)!
        dateFormatter.dateFormat = "EEEE, dd MMMM yyyy '| opens at' H:mm a"//"dd/MM/yyyy"
        
        let dateString = dateFormatter.string(from: date)
       // print(dateString)

        cell.eventTime.text = dateString
        cell.btnViewEvent.setTitleColor(UIColor.white, for: .normal)
 
        
        if data.image_url?.count != 0 {
//            let imageUrl = URL.init(string: BaseUrl.imageBaseUrl + (data.image_url?.first!)!)
            let abc = BaseUrl.imageBaseUrl + (data.image_url?.first!)!
            if let urlString = abc.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if let url = URL(string: urlString) {
                    // Use the cleaned URL
                    cell.eventImage.sd_setImage(with: url, placeholderImage: UIImage(named: "Mask group 1"))
                    
                }
            }
//            cell.eventImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Mask group 1"))
            
        }else{
            cell.eventImage.image = UIImage(named: "Mask group 1")
        }
        
        cell.btnViewEvent.tag = indexPath.row
        cell.btnViewEvent.setTitleColor(UIColor.white, for: .normal)
        cell.btnViewEvent.addTarget(self, action: #selector(viewActionBtn(_sender: )), for: .touchUpInside)
        
        return cell
    }
    
    @objc func viewActionBtn( _sender: UIButton){
        let vc = VideosListVC.instantiate(fromAppStoryboard: .map)
        vc.listId = eventListData[_sender.tag].id
        vc.comingForm = "Event"
        vc.showEventIntrest = eventListData[_sender.tag].showinterest_count
        self.pushToVC(vc, animated: true)
    }
    
}
