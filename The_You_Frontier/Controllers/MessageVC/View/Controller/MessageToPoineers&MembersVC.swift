//
//  MessageToPoineers&MembersVC.swift
//  The_You_Frontier
//
//  Created by CTS on 03/01/24.
//

import UIKit

class MessageToPoineers_MembersVC: UIViewController {

    //MARK: VAriables
    let youTubeVideoId = ["KLuTLF3x9sA","cFCm6zZWKvc","7PIji8OubXU","62XYzyMZ34w","0gcEyM3RE9Q","UV0mhY2Dxr0","pgNTOLRStE8","AhP5Tg_BLIk","7ZP7TWiOrDs","YgG1j40oPk8"]
    
    var cellData = [CellData]()
    var videoListData = [VideoList]()
    let callApiService = HttpUtility.shared
    
    @IBOutlet weak var messageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
      //  messageTableView.reloadData()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkNetwork()
    }
    
    //MARK:-  check internet Connection
    
    func checkNetwork () {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            Task{
                do{
                    showActivityIndicator()
                    
                    let response = try await callApiService.getOperation(requestUrl: BaseUrl.baseURL + BaseUrl.videoListURL , response: VideoListModel.self)
                    
                    if response.status == true {
                        self.videoListData = response.data ?? []
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                            self.hideActivityIndicator()
 
                            self.messageTableView.reloadData()
                            
                        }
                        
                    }
                    else{
                        self.hideActivityIndicator()
                        
                        self.ShowAlert(message: response.message ?? "")
                    }
                }
                
                catch{
                    self.hideActivityIndicator()
                    self.ShowAlert(message: error.localizedDescription)
                    
                }
            }
            
        }
        else {
            self.ShowAlert(message:TYF_AlertText.internetConnection)
        }
    }
    
    
    func setUpTableView(){
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.register(UINib(nibName: "MessagePioneerTblCell", bundle: .main), forCellReuseIdentifier: "MessagePioneerTblCell")
    }

   
    @IBAction func backActionBtn(_ sender: UIButton) {
        popViewController()
    }
    
}
