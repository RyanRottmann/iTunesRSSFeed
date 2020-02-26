//
//  MainTableViewController.swift
//  iTunesRSSFeedAPI
//
//  Created by Ryan on 2/19/20.
//  Copyright © 2020 Ryan Rottmann. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    var listOfAlbums = [Album](){
        didSet{// called immediately after new value is stored
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.title = "\(numOfResults) \(mainTitle)"
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //reloadData()
        getiTunesData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listOfAlbums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MainTableViewCell
        
        //setImageConstraints()
        
        let album = listOfAlbums[indexPath.row]
        
        if let imageUrl = URL(string: album.artworkUrl100),
            let imageData = try? Data(contentsOf: imageUrl){
            cell?.albumImage.image = UIImage(data: imageData)
        }
        cell?.albumTitle.text = album.name
        cell?.artistName.text = "By: " + album.artistName
        
        return cell!
    }
    

    
    public func reloadData(){
        var albumRequest = AlbumRequest()
        /*
        albumRequest.getAlbums{[weak self] result in
            switch result{
            case .failure(let error):
                print (error)
            case .success (let albums):
                
                self?.listOfAlbums = albums
            }
        }*/
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetailedView", sender: self)
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {// sets height for table view rows
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedViewController{
            let indexPath = tableView.indexPathForSelectedRow
            //let numReviews = listOfAlbums.count
            //indexPath.row < numReview
            let album = listOfAlbums[indexPath!.row]
                destination.album = album
        }
    }
    func getiTunesData(){
        var resourceString = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/25/explicit.json"
        let baseUrlString = "https://rss.itunes.apple.com/api/v1/us/"
        //var resourceURL: URL
        
        resourceString = baseUrlString
        resourceString += mediaType + "/"
        resourceString += feedType + "/all/"
        resourceString += String(numOfResults) + "/explicit.json"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        /*
        let jsonUrlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/25/explicit.json"
        guard let url = URL(string: jsonUrlString) else {
            return
        }
         do {
             let decoder = JSONDecoder()
            let albumResponse = try decoder.decode(MyFeed.self, from: jsonData)
            let albumDetails = albumResponse.feed.results
            mainTitle = albumResponse.feed.title
            print("main title is " + mainTitle)
             completion(.success(albumDetails))
         } catch {
             completion(.failure(.canNotProcessData))
         }

         */
        
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
