//
//  AccountVc.swift
//  Slack App
//
//  Created by Mohamed on 3/13/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

class AccountVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closeBtn(_ sender: Any) {
        performSegue(withIdentifier: unWind, sender: nil)
    }
    
}
