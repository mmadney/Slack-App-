//
//  AvatarCell.swift
//  Slack App
//
//  Created by Mohamed on 3/22/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

enum AvtarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configure(index:Int ,type:AvtarType){
        if type == AvtarType.dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }
    }
    
    func setupView(){
        self.layer.backgroundColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}
