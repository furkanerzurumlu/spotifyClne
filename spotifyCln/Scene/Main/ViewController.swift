//
//  ViewController.swift
//  spotifyCln
//
//  Created by Furkan Erzurumlu on 9.11.2022.
//

import UIKit


class ViewController: UIViewController {
    
    // MARK: Variables
    private var isEnebleSideBarView: Bool = false
    private var sideBarView: UIView!
    var cellImageView: UIImageView!
    var cellLabel: UILabel!
    
    
    @IBOutlet weak var followingCollectionView: UICollectionView!
    private let tableview: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    // MARK: Menu Variables
    enum MenuOptions: String, CaseIterable{
        case home = "Home"
        case profile = "My Profile"
        //case appRaiting = " "
        //case shareApp = " "
        //case settings = " "
        
        
        var imageName: String{
            switch self{
            case .home:
                return "house.fill"
            case .profile:
                return "airplane"
                //case .appRaiting:
                //return "star"
                //case .shareApp:
                //return "message"
                //case .settings:
                //return "gear"
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        setLayout()
        setTabBar()
        setupCollectionView()
        
        configureSideMenu()
        
       
        //navigationItem.leftBarButtonItem?.customView?.layer.borderColor = UIColor(named: "spotifyGreenColor")?.cgColor
    }
    // MARK: - Configure Side Menu
    fileprivate func configureSideMenu(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableview.backgroundColor = UIColor(named: "spotifyGreenColor")
        sideBarView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height))
        //sideMenuTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height))
        
        sideBarView.layer.borderWidth = 3
        sideBarView.backgroundColor = UIColor(named: "spotifyGreenColor")
        
        self.view.addSubview(sideBarView)
        self.sideBarView.addSubview(tableview)
    }
    // MARK: CollectionView Set
    fileprivate func setupCollectionView(){
        followingCollectionView?.register(FollowingCollectionViewCell.nibName, forCellWithReuseIdentifier: FollowingCollectionViewCell.identifer)
        
        followingCollectionView?.delegate = self
        followingCollectionView?.dataSource = self
        
    }
    // MARK: BarButtonItem
    private func configureItems(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(didTapSideMenuButton))
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "spotifyGreenColor")
    }
    @objc func didTapSideMenuButton(){
        //        print("Menu clicked")
        
        
        if isEnebleSideBarView{ //Close
            
            UIView.animate(withDuration: 1.5,delay: 0,usingSpringWithDamping: 0.8,initialSpringVelocity: 0,options: .curveEaseInOut) {
                self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
                self.tableview.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
                self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "spotifyGreenColor")
                
            }
            isEnebleSideBarView = false
            tableview.isHidden = true
            self.tabBarController?.tabBar.items?[1].isEnabled = true
            self.tabBarController?.tabBar.items?[0].isEnabled = true
            
            //self.tabBarController?.tabBar.isHidden = false
            
        }else{ //Open
            
            UIView.animate(withDuration: 1.5,delay: 0,usingSpringWithDamping: 0.8,initialSpringVelocity: 0,options: .curveEaseInOut){
                self.sideBarView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/2, height: self.view.bounds.height)
                self.tableview.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/2, height: self.view.bounds.height)
                self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "spotifyBlackColor")
                
            }
            isEnebleSideBarView = true
            tableview.isHidden = false
            
            self.tabBarController?.tabBar.items?[1].isEnabled = false
            self.tabBarController?.tabBar.items?[0].isEnabled = false
            
//            self.tabBarController?.viewControllers?.remove(at: 1)
            //self.tabBarController?.tabBar.isHidden = true
            
        }
    }
    // MARK: LayoutSet
    private func setLayout(){
        self.view.backgroundColor = UIColor(named: "spotifyBlackColor")
        self.navigationItem.title = "Following"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 30.0, green: 215.0, blue: 96.0)]
        
    }
    // MARK: TabBar Set
    private func setTabBar(){

        if let tabBarItem1 = self.tabBarController?.tabBar.items?[0]{
            tabBarItem1.title = "Following"
            tabBarItem1.image = UIImage(named: "followers")

        }

        if let tabBarItem2 = self.tabBarController?.tabBar.items?[1]{
            tabBarItem2.title = "My Followers"
            tabBarItem2.image = UIImage(named: "following")

        }
    }
    
}
// MARK: CollectionView Extension
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = followingCollectionView.dequeueReusableCell(withReuseIdentifier: FollowingCollectionViewCell.identifer, for: indexPath) as! FollowingCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 2.0, bottom: 1.0, right: 2.0)
    }
    
}
// MARK: TableView Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = UIColor(named: "spotifyBlackColor")
        cell.textLabel?.textColor = UIColor(named: "spotifyBlackColor")
        cell.backgroundColor = UIColor(named: "spotifyGreenColor")
        cell.contentView.backgroundColor = UIColor(named: "spotifyGreenColor")
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row{
        case 0:
            Router.shared.showMyProfileVC(navigaitonController: self.navigationController)
            didTapSideMenuButton()
        case 1:
            Router.shared.showSerachVC(navigationController: self.navigationController)
            didTapSideMenuButton()
        default:
            break
        }
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

