//
//  YoutubeSearchResponse.swift
//  MovieApp
//
//  Created by Shushant  on 30/10/25.
//

import Foundation


struct YoutubeSearchResponseModel: Codable{
    let items:[ItemProperty]?
}

struct ItemProperty:Codable{
    let id:IdProperties?
}

struct IdProperties: Codable{
    let videoId:String?
}
