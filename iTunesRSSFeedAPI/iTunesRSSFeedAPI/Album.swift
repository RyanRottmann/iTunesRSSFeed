//
//  Album.swift
//  iTunesRSSFeedAPI
//
//  Created by Ryan on 2/19/20.
//  Copyright © 2020 Ryan Rottmann. All rights reserved.
//

import UIKit

var mainTitle: String = "Top Albums"
var numOfResultsArray: [Int] = [10, 25, 50, 100]
var numOfResults: Int = 25
var mediaType = "apple-music"
var feedType = "top-albums"

struct MyFeed: Decodable{
    var feed: Feed
}

struct Feed: Decodable{
    var title: String
    var results: [Album]
}

struct Album: Decodable{
    var artistName: String
    var releaseDate: String
    var name: String
    var copyright: String?
    var artworkUrl100: String
    var url: String
}
