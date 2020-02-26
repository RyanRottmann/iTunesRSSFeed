//
//  AlbumRequest.swift
//  iTunesRSSFeedAPI
//
//  Created by Ryan on 2/19/20.
//  Copyright © 2020 Ryan Rottmann. All rights reserved.
//

import Foundation

enum ErrorType: Error{
    case noDataAvalible
    case canNotProcessData
}

struct AlbumRequest{/*
    var resourceURL: URL
    // https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/25/explicit.json
    var resourceString = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/25/explicit.json"
    let baseUrlString = "https://rss.itunes.apple.com/api/v1/us/"
    
    init(){
        resourceString = baseUrlString
        resourceString += mediaType + "/"
        resourceString += feedType + "/all/"
        resourceString += String(numOfResults) + "/explicit.json"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }

    mutating func getAlbums(completion: @escaping(Result<[Album], ErrorType>) -> Void){
        
        guard let resourceURL = URL(string: resourceString) else{return}
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data, _, _ in// data, response, possibleErorr
        
             guard let jsonData = data else {
                 completion(.failure(.noDataAvalible))
                 return
             }
            /*
            if let jsonString = String(data: data!, encoding: String.Encoding.utf8){
                print(jsonString)
            }*/
            
            //print(resourceURL)
            
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
            
         }
         dataTask.resume()
    }*/
}
