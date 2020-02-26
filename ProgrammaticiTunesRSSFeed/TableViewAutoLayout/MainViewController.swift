//
//  MainViewController.swift
//  TableViewAutoLayout
//
//  Created by Ryan on 2/20/20.
//  Copyright © 2020 Ryan Rottmann. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var listOfAlbums = [Album](){// List of
        didSet{// called immediately after new value is stored
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.title = "\(numOfResults) \(mainTitle)"
                
            }
        }
    }
    
    var tableView = UITableView()

    override func viewWillAppear(_ animated: Bool) {
        if(reloadData == true){
            getiTunesData()
            reloadData = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        configureTableView()
        setupSettingsButton()
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "mainCell")
        // register cells
        // set constraints
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getiTunesData(){
        var resourceString = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/25/explicit.json"
        let baseUrlString = "https://rss.itunes.apple.com/api/v1/us/"
        
        resourceString = baseUrlString
        resourceString += mediaType + "/"
        resourceString += feedType + "/all/"
        resourceString += String(numOfResults) + "/explicit.json"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        
        URLSession.shared.dataTask(with: resourceURL) {(data, response, err) in
            // check err
            // also check response status 200 ok
            guard let data = data else {// non optional data now
                print("Error retrieving data")
                return
            }
            //let dataAsString = String(data: data, encoding: .utf8)
            //print(dataAsString)
            do{
                let albumResponse = try JSONDecoder().decode(MyFeed.self, from: data)
                let returnAlbumArray = albumResponse.feed.results
                mainTitle = albumResponse.feed.title
                self.listOfAlbums = returnAlbumArray
                //print(returnAlbumArray)
            } catch let jsonError{
                print("Error serializing json: ", jsonError)
            }
        }.resume()
    }
    
    func setupSettingsButton(){
        let settingsButton = UIBarButtonItem(title: "Settings", style: .done, target: self, action: #selector(settingsButtonTapped))
        self.navigationItem.leftBarButtonItem  = settingsButton
    }
    
    @objc func settingsButtonTapped(){
        let nextScreen = SettingsViewController()
        navigationController?.pushViewController(nextScreen, animated: false)
        
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{// Can also be done at top
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {// Loads Data in each TableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as! MainTableViewCell
        let myCell = listOfAlbums[indexPath.row]
        cell.set(cell: myCell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let nextScreen = DetailedViewController()
        
        let album = listOfAlbums[indexPath.row]
        nextScreen.album = album// Sets the selected cells album to the album in the DetailedView
        
        navigationController?.pushViewController(nextScreen, animated: false)
    }
}
