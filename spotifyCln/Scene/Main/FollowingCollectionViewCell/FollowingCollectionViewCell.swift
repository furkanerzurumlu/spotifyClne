//
//  FollowingCollectionViewCell.swift
//  spotifyCln
//
//  Created by Furkan Erzurumlu on 9.11.2022.
//

import UIKit

class FollowingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var firstLayer: UIView!
    @IBOutlet weak var uniqueLayer: UIView!
    
    //MARK : User Value
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
        self.firstLayer.layer.cornerRadius = 15
        self.uniqueLayer.layer.cornerRadius = 15
        
        firstLayer.backgroundColor = UIColor(named: "spotifyGreenColor")
        uniqueLayer.backgroundColor = UIColor(named: "spotifyBlackColor")
        
    }
    private func setUserValue(){
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        
        userName.textColor = UIColor.darkGray
        currentMusic.textColor = UIColor.darkGray
        
        
        }
}

extension FollowingCollectionViewCell {
    static var identifer: String {
        return String(describing: self)
    }
    static var nibName: UINib {
        return UINib(nibName: identifer, bundle: nil)
    }
}
