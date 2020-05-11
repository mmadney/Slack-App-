//
//  RoundView.swift
//  Slack App
//
//  Created by Mohamed on 5/11/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

@IBDesignable
class RoundView: UIView {

    @IBInspectable var roundCorner : CGFloat = 0{
        didSet{
            self.layer.cornerRadius = roundCorner
        }
    }
}
