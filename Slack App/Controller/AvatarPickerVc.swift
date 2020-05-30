//
//  AvatarPickerVc.swift
//  Slack App
//
//  Created by Mohamed on 3/22/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

class AvatarPickerVc: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
 
    

    @IBOutlet weak var segmentTheme: UISegmentedControl!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    //variabl
    var avatartype = AvtarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.delegate = self
        CollectionView.dataSource = self

        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 28
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarPickerCell, for: indexPath) as? AvatarCell {
            cell.configure(index: indexPath.item, type: avatartype)
            return cell
        }
        else{
            return AvatarCell()
        }
        
     }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //calaclte dimension of the cell in runtime
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numOfCloumns : CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numOfCloumns = 4
        }
        
        let spacebetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        //CLAULTE CELL DIMENSION = (WIDTHCOLLECTIONVIEW - PADING - (SPACE * NUMCOLM(Becuse space equal num colum -1)-1)/num ofcolums)
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfCloumns - 1) * spacebetweenCells) / numOfCloumns
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatartype == .dark {
            UserDataServices.instance.setAvtarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataServices.instance.setAvtarName(avatarName: "light\(indexPath.item)")
        }
        
        dismiss(animated: true, completion: nil)
      
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        if segmentTheme.selectedSegmentIndex == 0  {
            avatartype = .dark
        } else {
            avatartype = .light
        }
        
        CollectionView.reloadData()
        
    }
    

    
}
