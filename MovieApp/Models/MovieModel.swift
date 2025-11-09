//
//  MovieModel.swift
//  MovieApp
//
//  Created by Shushant  on 28/10/25.
//

import SwiftData


struct TMDBAPIObject:Decodable{
    var results: [MovieModel] = []
}

@Model
class MovieModel: Decodable, Identifiable, Hashable{
    @Attribute(.unique) var id:Int?
    var title:String?
    var name:String?
    var overview:String?
    var posterPath:String?
    
    init(id: Int? = nil, title: String? = nil, name: String? = nil, overview: String? = nil, posterPath: String? = nil) {
        self.id = id
        self.title = title
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
    }
    
    enum CodingKeys:CodingKey{
        case id
        case title
        case name
        case overview
        case posterPath
    }
    
    required init(from decoder: any Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
    }
    
    static var previewMovies = [
        MovieModel(id:1,title: "Dark Knight",name:"Dark Knight",overview: "I am Batman",posterPath: Constants.testTitleURL),
        MovieModel(id:2,title: "Beetle Juice",name:"Beetle Juice",overview: "Beetle Juice vali movie",posterPath: Constants.testTitleURL3),
        MovieModel(id:3,title: "Pulp fiction",name:"Pulp fiction",overview: "ATMKBFGJ",posterPath: Constants.testTitleURL2)
    ]
}
