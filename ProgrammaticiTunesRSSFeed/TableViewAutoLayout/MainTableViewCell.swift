//
//  MainTableViewCell.swift
//  TableViewAutoLayout
//
//  Created by Ryan on 2/20/20.
//  Copyright © 2020 Ryan Rottmann. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    var cellImageView = UIImageView()
    var titleLabel = UILabel()
    var artistLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cellImageView)
        addSubview(titleLabel)
        addSubview(artistLabel)
        
        configureImageView()
        
        configureTitle()
        setTitleConstraints()
        
        configureArtist()
        setArtistConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cell: Album){
        
        [NSLayoutConstraint .deactivate(cellImageView.constraints)]// Deletes previous constraints
        setImageConstraints()// set image constraints due to variable size
        
        if let imageUrl = URL(string: cell.artworkUrl100),
            let imageData = try? Data(contentsOf: imageUrl){
                cellImageView.image = UIImage(data: imageData)
            }
        titleLabel.text = cell.name
        artistLabel.text = "By: \(cell.artistName)"
    }
    
    func configureImageView(){
        cellImageView.layer.cornerRadius = 10
        cellImageView.clipsToBounds = true // allows to show corner radius
    }
    
    func setImageConstraints(){
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  12).isActive = true
        cellImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        //print(mediaType)
        if(mediaType == "apple-music" || mediaType == "ios-apps"){// square image ratio
            cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor).isActive = true
        } else if(mediaType == "music-videos"){// wide image ratio
            cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor, multiplier: 16/9).isActive = true
        } else{// mediaType == "movies" tall image ratio
            cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor, multiplier: 2/3).isActive = true
        }
       
    }
    
    func configureTitle(){
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setTitleConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 2).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2).isActive = true
    }
    
    func configureArtist(){
        artistLabel.numberOfLines = 2
        artistLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setArtistConstraints(){
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 2).isActive = true
        artistLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2).isActive = true
    }
    
}
