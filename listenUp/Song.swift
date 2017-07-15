//
//  Song.swift
//  listenUp
//
//  Created by Marcos Mejias on 04/06/2017.
//  Copyright © 2017 Marcos Mejias. All rights reserved.
//

import Foundation

class Song {
    
    //Stored Properties
    var wrapperType : String? = nil
    var kind : String? = nil
    var collectionName : String? = nil
    var collectionCensoredName : String? = nil
    var trackCensoredName : String? = nil
    var collectionArtistName : String? = nil
    var trackPrice : Int? = nil
    var releaseDate : String? = nil
    var trackTimeMillis : Int? = nil
    var currency : String? = nil
    var primaryGenreName : String? = nil
    var trackName : String? = nil
    var artistName : String? = nil
    var artworkUrl : String? = nil
    var previewUrl : String? = nil
    
    init(trackName : String, artistName : String, artworkUrl : String){
        self.trackName = trackName
        self.artistName = artistName
        self.artworkUrl = artworkUrl
    }
    
    init(wrapperType : String,kind : String ,artistName : String,collectionName : String,trackName : String ,collectionCensoredName : String,trackCensoredName : String,artworkUrl : String ,trackPrice : Int,releaseDate : String,trackTimeMillis : Int,currency : String,primaryGenreName : String, previewUrl : String){
    
        self.wrapperType = wrapperType
        self.kind = kind
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.collectionCensoredName = collectionCensoredName
        self.trackCensoredName = trackCensoredName
        self.artworkUrl = artworkUrl
        self.trackPrice = trackPrice
        self.releaseDate = releaseDate
        self.trackTimeMillis = trackTimeMillis
        self.currency = currency
        self.primaryGenreName = primaryGenreName
        self.previewUrl = previewUrl
    }
}
