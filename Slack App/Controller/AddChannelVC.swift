//
//  AddChannelVC.swift
//  Slack App
//
//  Created by Mohamed on 5/28/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    @IBOutlet weak var channelName: UITextField!
    @IBOutlet weak var channelDescrptions: UITextField!
    @IBOutlet weak var bgView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupview()
        
    }


    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CreateChannel(_ sender: Any) {
        guard let channelNameWrap = channelName.text , channelName.text != "" ,
            let channelDescrptionwrap = channelDescrptions.text , channelDescrptions.text != ""  else {
            return
        }
        
        SocketServices.instance.AddChannel(channelName: channelNameWrap, channelDescrption: channelDescrptionwrap) { (sucees) in
            if sucees {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("error In ADD cHANNEL")
            }
        }

    }
    func setupview(){
        let closetoush = UITapGestureRecognizer(target: self, action: #selector(handleScreenTab(_:)))
        bgView.addGestureRecognizer(closetoush)
    }
    
    @objc func handleScreenTab(_ sender : UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    

}
