//
//  MainTableViewCell.swift
//  iTunesRSSFeedAPI
//
//  Created by Ryan on 2/19/20.
//  Copyright © 2020 Ryan Rottmann. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setImageConstraints(){
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        albumImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  12).isActive = true
        albumImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        albumImage.widthAnchor.constraint(equalTo: albumImage.heightAnchor, multiplier: 16/9).isActive = true
    }
}
