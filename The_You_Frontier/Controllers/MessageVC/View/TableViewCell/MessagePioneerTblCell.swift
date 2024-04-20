//
//  MessagePioneerTblCell.swift
//  The_You_Frontier
//
//  Created by Chawtech on 10/01/24.
//

import UIKit
import WebKit
import AVKit
import youtube_ios_player_helper

class MessagePioneerTblCell: UITableViewCell,Reusable , YTPlayerViewDelegate{

    @IBOutlet weak var messageView: UIView!
  
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var imgVideoImage: UIImageView!
    @IBOutlet weak var avPlayerView: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var lblUserName: MyRegularLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.messageView.setViewBorderColor(color: UIColor.bgColor, width: 1,cornerRadius: 15)
            self.playerView.delegate = self
        }

    }

    func loadYoutube(videoID:String) {

//        playerView.load(withVideoId: "KLuTLF3x9sA", playerVars: ["playsinline": 1])
        DispatchQueue.main.async {
            
            self.playerView.load(withVideoId: "\(videoID)", playerVars: ["playsinline": 1])
        }
    }

    
    
}
