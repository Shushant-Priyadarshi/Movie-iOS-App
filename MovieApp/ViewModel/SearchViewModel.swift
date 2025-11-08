//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Shushant  on 08/11/25.
//

import Foundation

@Observable
class SearchViewModel{
    private(set) var errorMessage:String?
    private(set) var searchTitle: [MovieModel] = []
    private let dataFetcher = DataFetcher()
    
    
    
    //function to search the movie or tv
    func getSearchedMovieOrTV(by media:String, for movieOrTVShowName:String) async{
        do{
            errorMessage = nil
            if movieOrTVShowName.isEmpty{
                searchTitle = try await dataFetcher.fetchMovies(for: media, by: "trending")
            }else{
                searchTitle = try await dataFetcher.fetchMovies(for: media, by: "search", with: movieOrTVShowName)
            }
        }catch{
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
}
