//
//  NewsTableViewExtension.swift
//  The_You_Frontier
//
//  Created by CTS on 11/01/24.
//

import Foundation
import UIKit
import SDWebImage

extension NewsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(NewsTableViewCell.self, for: indexPath)
        let data = newsData[indexPath.row]
        cell.cellTitleLbl.text = data.title ?? ""
        cell.cellDescriptionLbl.text = data.description ?? ""
        cell.cellHeaderLbl.isHidden = true
        
//        let imageUrl = URL.init(string: BaseUrl.imageBaseUrl + (data.image_url)!)
        var str1 = data.image_url ?? ""
        let urlStr = BaseUrl.imageBaseUrl + str1
        
        if let urlString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlString) {
                // Use the cleaned URL
                cell.cellIImgView.sd_setImage(with: url, placeholderImage: UIImage(named: "Mask group-4"))
             
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailVC.instantiate(fromAppStoryboard: .map)
        
        let data = newsData[indexPath.row]

        var str1 = data.image_url ?? ""
        let urlStr = BaseUrl.imageBaseUrl + str1
        
        if let urlString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlString) {
                vc.newsImageUrl = url
             
            }
        }
        let imageUrl = URL.init(string: BaseUrl.imageBaseUrl + (data.image_url)!)
        
        
        vc.newsTitle = data.title ?? ""
        vc.newsDiscription = data.description ?? ""
//        vc.newsImageUrl = imageUrl
        
        pushToVC(vc, animated: true)
    }
    
    
}
