//
//  MyFollowersCollectionViewCell.swift
//  spotifyCln
//
//  Created by Furkan Erzurumlu on 9.11.2022.
//

import UIKit

class MyFollowersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var uniqueLayer: UIView!
    @IBOutlet weak var firstLayer: UIView!
    
    //MARK: User Value
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var currentMusic: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellLayout()
        setUserValue()
    }

    private func setCellLayout(){
        firstLayer.layer.cornerRadius = 15
        uniqueLayer.layer.cornerRadius = 15
        
        firstLayer.backgroundColor = UIColor(named: "spotifyGreenColor")
        uniqueLayer.backgroundColor = UIColor(named: "spotifyBlackColor")
    }
    private func setUserValue(){
        userImage.layer.cornerRadius = userImage.frame.height/2
        userName.textColor = UIColor.darkGray
        currentMusic.textColor = UIColor.darkGray
    }
}

extension MyFollowersCollectionViewCell {
    static var identifier: String{
        return String(describing: self)
    }
    static var nibName: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
