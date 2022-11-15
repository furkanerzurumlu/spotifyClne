//
//  Router.swift
//  spotifyCln
//
//  Created by Furkan Erzurumlu on 14.11.2022.
//

import Foundation
import UIKit

final class Router{
    static var shared: Router = Router()
    
    func showMyProfileVC(navigaitonController: UINavigationController?){
        let myProfile = MyProfileVC.instantiate(storyboard: .profile)
        navigaitonController?.pushViewController(myProfile, animated: true)
    }
    
    func showSerachVC(navigationController: UINavigationController?){
        let search = SearchVC.instantiate(storyboard: .search)
        navigationController?.pushViewController(search, animated: true)
    }
}
