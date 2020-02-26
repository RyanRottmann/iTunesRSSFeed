//
//  SettingsViewController.swift
//  iTunesRSSFeedAPI
//
//  Created by Ryan on 2/19/20.
//  Copyright © 2020 Ryan Rottmann. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var mediaTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var numOfResultsStepper: UIStepper!
    @IBOutlet weak var stepperValue: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //print("ViewWillDissapear")
        print("now")
        
    }
    
    @IBAction func mediaTypeSegmentedControlChanged(_ sender: Any) {
        switch mediaTypeSegmentedControl.selectedSegmentIndex{
        case 0:
            mediaType = "apple-music"
            feedType = "top-albums"
        case 1:
            mediaType = "music-videos"
            feedType = "top-music-videos"
            print("musicVideosSelected")
            print(mediaType)
            print(feedType)
        case 2:
            mediaType = "ios-apps"
            feedType = "top-free"
        case 3:
            mediaType = "movies"
            feedType = "top-movies"
        default:
            mediaType = "apple-music"
            feedType = "top-albums"
        }
    }
    
    @IBAction func numOfResultsStepperValueChanged(_ sender: Any) {
        // num of results 10, 25, 50, 100
        numOfResults = numOfResultsArray[Int(numOfResultsStepper.value)]
        stepperValue.text = String(numOfResults)
    }
    /*
    func prepare(for segue: UIStoryboardSegue, sender: SettingsViewController) {
        //MainTableViewController.reloadData(M)
        //print("leaving settings")
        print(mediaType)
        print(feedType)
    }*/
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("now")
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
