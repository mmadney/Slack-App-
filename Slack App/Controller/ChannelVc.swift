//
//  ChannelVc.swift
//  Slack App
//
//  Created by Mohamed on 3/12/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

class ChannelVc: UIViewController {
    
    @IBAction func prepareForUnWind(segue : UIStoryboardSegue){}

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
    }
    

}

