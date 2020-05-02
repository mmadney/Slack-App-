//
//  RoundImageView.swift
//  Slack App
//
//  Created by Mohamed on 5/2/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

@IBDesignable
class RoundImageView: UIImageView {
   
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
