//
//  Extension+ShowEventImagesVC.swift
//  The_You_Frontier
//
//  Created by Chawtech on 01/02/24.
//

import Foundation

import UIKit

extension ShowEventImagesVC: UICollectionViewDelegate ,UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosListCell", for: indexPath) as! VideosListCell
       // cell.VideoImage.image = UIImage(named: videosList[indexPath.row])
        cell.VideoImage.layer.cornerRadius = 5
        
        if videosList.count != 0 {
            var str1 = videosList[indexPath.row]
            let urlStr = BaseUrl.imageBaseUrl + (str1)
            
            if let urlString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if let url = URL(string: urlString) {
                    // Use the cleaned URL
                    cell.VideoImage.sd_setImage(with: url, placeholderImage: UIImage(named: "Mask group-4"))
                    
                }
            }

        }else{
            cell.VideoImage.image = UIImage(named: "Mask group 1")
        }

        return cell
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }

}
