//
//  Extension+MessageToPoineers_MembersVC.swift
//  The_You_Frontier
//
//  Created by Chawtech on 10/01/24.
//

import Foundation
import youtube_ios_player_helper
import UIKit

extension MessageToPoineers_MembersVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoListData.count//2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MessagePioneerTblCell.self, for: indexPath)
        let data = videoListData[indexPath.row]
        
        cell.lblUserName.text = data.title ?? ""
      
        DispatchQueue.main.async {
            
             
             let inputString = "\(data.videoURL!)"
             var splits = inputString.components(separatedBy: "https://www.youtube.com/shorts/")
             print(splits)
             
             let videoId = splits.filter {$0 != ""}
          //  cell.loadYoutube(videoID:videoId[0])
            cell.loadYoutube(videoID:data.videoId!)
        }

        return cell
    }
    
    
    
}
