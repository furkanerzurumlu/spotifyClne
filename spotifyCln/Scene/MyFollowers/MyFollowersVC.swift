//
//  MyFollowersVC.swift
//  spotifyCln
//
//  Created by Furkan Erzurumlu on 9.11.2022.
//

import UIKit

class MyFollowersVC: UIViewController {
    
    private var isEnebleSideBarView: Bool = false
    private var sideBarView: UIView!
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    enum MenuOptions: String, CaseIterable{
        case home = "Home"
        case info = "info"
        case appRaiting = "App Raiting"
        case shareApp = "Share App"
        case settings = "Settings"
        
        var imageName: String{
            switch self{
            case .home:
                return "house"
            case .info:
                return "airplane"
            case .appRaiting:
                return "star"
            case .shareApp:
                return "message"
            case .settings:
                return "gear"
            }
        }
    }
    
    var cellImageView: UIImageView!
    var cellLabel: UILabel!
    
    @IBOutlet weak var myFollowersCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        configureItems()
        setupCollectionView()
        configureSideMenu()
        
    }
    fileprivate func configureSideMenu(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.backgroundColor = UIColor(named: "spotifyGreenColor")
        sideBarView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height))
        sideBarView.layer.borderWidth = 3
        sideBarView.backgroundColor = UIColor(named: "spotifyGreenColor")
        
        self.view.addSubview(sideBarView)
        self.sideBarView.addSubview(tableView)
    }
    fileprivate func setupCollectionView(){
        myFollowersCollectionView?.register(MyFollowersCollectionViewCell.nibName, forCellWithReuseIdentifier: MyFollowersCollectionViewCell.identifier)
        
        myFollowersCollectionView?.delegate = self
        myFollowersCollectionView?.dataSource = self
    }
    fileprivate func setLayout(){
        self.view.backgroundColor = UIColor(named: "spotifyBlackColor")
        self.navigationItem.title = "My Followers"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 30.0, green: 215.0, blue: 96.0)]
    }
    
    fileprivate func configureItems(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(didTapSideMenuButton))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.rgb(red: 30.0, green: 215.0, blue: 96.0)
    }
    @objc func didTapSideMenuButton(){
        print("my following tapped")
        if isEnebleSideBarView{
            
            UIView.animate(withDuration: 1.5){
                self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
                self.tableView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
                self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "spotifyGreenColor")
            }
            isEnebleSideBarView = false
            tableView.isHidden = true
        }else{
            UIView.animate(withDuration: 1.5){
                self.sideBarView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/2, height: self.view.bounds.height)
                self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/2, height: self.view.bounds.height)
                self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "spotifyBlackColor")
            }
            isEnebleSideBarView = true
            tableView.isHidden = false
        }
    }
}

extension MyFollowersVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myFollowersCollectionView.dequeueReusableCell(withReuseIdentifier: MyFollowersCollectionViewCell.identifier, for: indexPath) as! MyFollowersCollectionViewCell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 2.0, bottom: 1.0, right: 2.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let withPerItem = myFollowersCollectionView.frame.width - layout.minimumInteritemSpacing
        
        return CGSize(width: withPerItem, height: 120)
    }
}

extension MyFollowersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
        let item = MenuOptions.allCases[indexPath.row]
    }
}
