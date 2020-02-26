//
//  SettingsViewController.swift
//  TableViewAutoLayout
//
//  Created by Ryan on 2/25/20.
//  Copyright © 2020 Ryan Rottmann. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var mediaTypeSC = UISegmentedControl()
    var numOfResultsLabel = UILabel()
    var numOfResultsStepper = UIStepper()
    var feedTypeSC = UISegmentedControl()
    var feedTypes = ["Top Albums", "Top Songs", "New Releases", "Coming Soon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        numOfResultsLabel.textColor = .label
        
        view.addSubview(numOfResultsLabel)
        view.addSubview(numOfResultsStepper)
        
        configureMediaType()
        configureNumOfResultsLabel()
        configureNumOfResultsStepper()
        
        if(mediaType == "apple-music" || mediaType == "ios-apps"){//load feedTypeSC for apple-music and ios-apps otherwise it is hidden
             configureFeedType()
        }
        //print("load")
    }
    
    func configureMediaType(){
        let mediaTypes = ["Apple Music", "Music Videos", "iOS Apps", "Movies"]
        mediaTypeSC = UISegmentedControl(items: mediaTypes)
        
        mediaTypeSC.backgroundColor = .gray
        mediaTypeSC.addTarget(self, action: #selector(mediaTypeChanged), for: .valueChanged)
        
        view.addSubview(mediaTypeSC)
        mediaTypeSC.translatesAutoresizingMaskIntoConstraints = false
        mediaTypeSC.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mediaTypeSC.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mediaTypeSC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        mediaTypeSC.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        mediaTypeSC.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc func mediaTypeChanged(_ segmentedControl: UISegmentedControl){
        reloadData = true
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            //print(segmentedControl.selectedSegmentIndex)
            mediaType = "apple-music"
            feedType = "top-albums"
            configureFeedType()
            feedTypeSC.isHidden = false
        case 1:
            //print(segmentedControl.selectedSegmentIndex)
            mediaType = "music-videos"
            feedType = "top-music-videos"
            feedTypeSC.isHidden = true
        case 2:
            //print(segmentedControl.selectedSegmentIndex)
            mediaType = "ios-apps"
            feedType = "top-free"
            configureFeedType()
            feedTypeSC.isHidden = false
        case 3:
            //print(segmentedControl.selectedSegmentIndex)
            mediaType = "movies"
            feedType = "top-movies"
            feedTypeSC.isHidden = true
        default:
            print("default")
        }
    }
    
    func configureNumOfResultsLabel(){
        numOfResultsLabel.text = String("Number of results: \(numOfResults)")
        numOfResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        numOfResultsLabel.topAnchor.constraint(equalTo: mediaTypeSC.bottomAnchor, constant: 30).isActive = true
        numOfResultsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        numOfResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func configureNumOfResultsStepper(){
        numOfResultsStepper.translatesAutoresizingMaskIntoConstraints = false
        numOfResultsStepper.topAnchor.constraint(equalTo: numOfResultsLabel.bottomAnchor, constant: 30).isActive = true
        numOfResultsStepper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        numOfResultsStepper.wraps = false
        numOfResultsStepper.maximumValue = 3
        numOfResultsStepper.minimumValue = 0
        numOfResultsStepper.value = numOfResultsIndex
        numOfResultsStepper.addTarget(self, action: #selector(stepperPressed), for: .valueChanged)
    }
    @objc func stepperPressed(){
        //print(numOfResultsStepper.value)
        numOfResults = numOfResultsArray[Int(numOfResultsStepper.value)]
        numOfResultsLabel.text = String("Number of results: \(numOfResults)")
        numOfResultsIndex = numOfResultsStepper.value
        reloadData = true
    }
    
    func configureFeedType(){// Configures second segmented control
        if(mediaType == "apple-music"){// Changes titles for feedTypeSC
            feedTypes = ["Top Albums", "Top Songs", "New Music", "Coming Soon"]
        } else {
            feedTypes = ["Top Free", "Top Paid", "Top Grossing", "Top Free iPad"]
        }
        
        feedTypeSC = UISegmentedControl(items: feedTypes)
        
        feedTypeSC.backgroundColor = .gray
        if(mediaType == "apple-music"){// selects correct action for feedTypeSC by mediaType
            feedTypeSC.addTarget(self, action: #selector(feedTypeChanged), for: .valueChanged)
        } else {// ios-apps
            feedTypeSC.addTarget(self, action: #selector(feedTypeChanged2), for: .valueChanged)
        }
        
        view.addSubview(feedTypeSC)
        feedTypeSC.translatesAutoresizingMaskIntoConstraints = false
        feedTypeSC.topAnchor.constraint(equalTo: numOfResultsStepper.bottomAnchor, constant: 50).isActive = true
        feedTypeSC.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        feedTypeSC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        feedTypeSC.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        feedTypeSC.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc func feedTypeChanged(_ segmentedControl: UISegmentedControl){// apple-music
        reloadData = true
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            //print(segmentedControl.selectedSegmentIndex)
            feedType = "top-albums"
        case 1:
            //print(segmentedControl.selectedSegmentIndex)
            feedType = "top-songs"
        case 2:
            //print(segmentedControl.selectedSegmentIndex)
            feedType = "new-releases"
        case 3:
            //print(segmentedControl.selectedSegmentIndex)
            feedType = "coming-soon"
        default:
            print("default")
        }
    }
    
    @objc func feedTypeChanged2(_ segmentedControl: UISegmentedControl){// ios-apps
        reloadData = true
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            //print(segmentedControl.selectedSegmentIndex)
            feedType = "top-free"
        case 1:
            //print(segmentedControl.selectedSegmentIndex)
            feedType = "top-paid"
        case 2:
            //print(segmentedControl.selectedSegmentIndex)
            feedType = "top-grossing"
        case 3:
            //print(segmentedControl.selectedSegmentIndex)
            feedType = "top-free-ipad"
        default:
            print("default")
        }
    }

}
