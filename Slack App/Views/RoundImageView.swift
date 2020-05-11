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
   
    var bgcolor: UIColor?

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
    
    func changeBackgroundColor() -> String {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        bgcolor = UIColor(red: r, green: g, blue: b, alpha: 1)
        let avtarColor = "[\(r),\(g),\(b),1]"
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = self.bgcolor
        }
        return avtarColor
    }
    func updateBackGroundColor(bgcolor: UIColor){
        self.backgroundColor = bgcolor
    }
    
    func checkBgCoLor() -> Bool{
        if bgcolor == nil {
            return true
        } else {
            return false
        }
    }

}
