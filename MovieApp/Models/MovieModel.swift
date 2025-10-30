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
    
    static var previewMovies = [
        MovieModel(id:1,title: "Dark Knight",name:"Dark Knight",overview: "I am Batman",posterPath: Constants.testTitleURL),
        MovieModel(id:2,title: "Beetle Juice",name:"Beetle Juice",overview: "Beetle Juice vali movie",posterPath: Constants.testTitleURL3),
        MovieModel(id:3,title: "Pulp fiction",name:"Pulp fiction",overview: "ATMKBFGJ",posterPath: Constants.testTitleURL2)
    ]
}
