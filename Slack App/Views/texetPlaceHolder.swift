//
//  texetPlaceHolder.swift
//  Slack App
//
//  Created by Mohamed on 5/2/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

@IBDesignable
class texetPlaceHolder: UITextField {

   
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView(){
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
    }


}
