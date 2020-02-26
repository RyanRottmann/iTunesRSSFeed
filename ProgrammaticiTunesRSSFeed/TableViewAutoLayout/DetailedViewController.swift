//
//  DetailedViewController.swift
//  TableViewAutoLayout
//
//  Created by Ryan on 2/25/20.
//  Copyright © 2020 Ryan Rottmann. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    var album: Album?
    
    var imageView = UIImageView()
    var titleLabel = UILabel()
    var artistLabel = UILabel()
    var releaseDateLabel = UILabel()
    var copyrightLabel = UILabel()
    var secondLinkButton = UIButton()
    var mainLinkButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = album?.name
        self.titleLabel.textColor = .label
        self.view.backgroundColor = .systemBackground
        
        addSubViews()
        configureView()
    }
    
    func addSubViews(){
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(artistLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(copyrightLabel)
        view.addSubview(secondLinkButton)
        view.addSubview(mainLinkButton)
    }
    
    func configureView(){
        configureImageView()
        setImageConstraints()
        
        configureTitle()
        setTitleConstraints()
        
        configureArtist()
        setArtistConstraints()
        
        configureReleaseDate()
        setReleaseDateConstraints()
        
        configureCopyright()
        setCopyrightConstraints()
        
        if(mediaType != "movies"){// movies do not have an Artist Url link
            configureSecondLink()
            setSecondLinkConstraints()
        }
        
        configureMainLink()
        setMainLink()
    }
    
    func configureImageView(){// Configure Image View
        if let imageUrl = URL(string: album!.artworkUrl100),
            let imageData = try? Data(contentsOf: imageUrl){
                imageView.image = UIImage(data: imageData)
            }
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true // allows to show corner radius
    }
    
    func setImageConstraints(){// Set Image View Constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        if(mediaType == "apple-music" || mediaType == "ios-apps"){// square image ratio
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        } else if(mediaType == "music-videos"){// wide image ratio
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 16/9).isActive = true
        } else{// mediaType == "movies" tall image ratio
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 2/3).isActive = true
        }
    }
    
    func configureTitle(){
        titleLabel.font = titleLabel.font.withSize(24)
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = album?.name
    }
    func setTitleConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
    }
    
    func configureArtist(){
        artistLabel.numberOfLines = 0
        artistLabel.adjustsFontSizeToFitWidth = true
        artistLabel.text = "By: \(album!.artistName)"
    }
    func setArtistConstraints(){
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
    }
    
    func configureReleaseDate(){
        releaseDateLabel.numberOfLines = 0
        releaseDateLabel.adjustsFontSizeToFitWidth = true
        releaseDateLabel.text = "Release Date: \(album!.releaseDate ?? "unknown")"
    }
    func setReleaseDateConstraints(){
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 2).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
    }
    
    func configureCopyright(){
        copyrightLabel.numberOfLines = 2
        copyrightLabel.adjustsFontSizeToFitWidth = true
        copyrightLabel.text = album?.copyright
    }
    func setCopyrightConstraints(){
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 2).isActive = true
        copyrightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        copyrightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5).isActive = true
    }
    
    func configureSecondLink(){
        if(mediaType == "apple-music" || mediaType == "music-videos"){// sets the title for the secondary link to the creator of the media
            secondLinkButton.setTitle("Artist Link", for: .normal)
        }else {// mediaType == "ios apps"
            secondLinkButton.setTitle("Developer Link", for: .normal)
        }

        secondLinkButton.backgroundColor = .gray
        secondLinkButton.titleLabel?.textColor = .label
        secondLinkButton.addTarget(self, action: #selector(artistButtonPress), for: .touchUpInside)
        secondLinkButton.layer.cornerRadius = 10
        secondLinkButton.clipsToBounds = true // allows to show corner radius
    }
    func setSecondLinkConstraints(){
        secondLinkButton.translatesAutoresizingMaskIntoConstraints = false
        secondLinkButton.bottomAnchor.constraint(equalTo: mainLinkButton.topAnchor, constant: -10).isActive = true
        secondLinkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondLinkButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        secondLinkButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc func artistButtonPress(){
        if let album = album,
            let url = URL(string: album.artistUrl!){
            print(url)
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    func configureMainLink(){
        if (mediaType == "apple-music"){// Sets the title for the main link
            mainLinkButton.setTitle("Album Link", for: .normal)
        } else if(mediaType == "music-videos"){
            mainLinkButton.setTitle("Video Link", for: .normal)
        } else if (mediaType == "ios-apps"){
            mainLinkButton.setTitle("Download Link", for: .normal)
        } else{// mediaType == "movies"
            mainLinkButton.setTitle("Movie Link", for: .normal)
        }
        
        mainLinkButton.backgroundColor = .gray
        mainLinkButton.titleLabel?.textColor = .white
        mainLinkButton.addTarget(self, action: #selector(albumButtonPress), for: .touchUpInside)
        mainLinkButton.layer.cornerRadius = 10
        mainLinkButton.clipsToBounds = true // allows to show corner radius
    }
    func setMainLink(){
        mainLinkButton.translatesAutoresizingMaskIntoConstraints = false
        mainLinkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        mainLinkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLinkButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        mainLinkButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc func albumButtonPress(){
        if let album = album,
            let url = URL(string: album.url){
            print(url)
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
}
