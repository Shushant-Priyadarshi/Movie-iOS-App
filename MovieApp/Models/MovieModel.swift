//
//  MovieModel.swift
//  MovieApp
//
//  Created by Shushant  on 28/10/25.
//

import Foundation


struct APIObject:Decodable{
    var results: [MovieModel] = []
}

struct MovieModel: Decodable, Identifiable{
    var id:Int?
    var title:String?
    var name:String?
    var overview:String?
    var posterPath:String?
}
