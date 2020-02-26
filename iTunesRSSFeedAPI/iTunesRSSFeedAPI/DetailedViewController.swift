//
//  DetailedViewController.swift
//  iTunesRSSFeedAPI
//
//  Created by Ryan on 2/19/20.
//  Copyright © 2020 Ryan Rottmann. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    var album: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let album = album{
            albumTitle.text = album.name
            artistName.text = album.artistName
            if let imageUrl = URL(string: album.artworkUrl100),
                let imageData = try? Data(contentsOf: imageUrl){
                albumImage.image = UIImage(data: imageData)
            }
        }
        
    }// End of viewDidLoad
    
    @IBAction func iTunesURLPressed(_ sender: Any) {
        if let album = album,
            let url = URL(string: album.url){
            print(url)
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
}

