//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Shushant  on 29/10/25.
//

import Foundation

@Observable
class MovieViewModel{
    
    enum FetchStatus{
        case notStarted
        case fetching
        case success
        case failed(underlyingError:Error)
    }
    
    private(set) var homeStatus: FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()
    
    var trendingMovies: [MovieModel] = []
    
    func getTredingMovies() async{
        homeStatus = .fetching
        
        do{
            trendingMovies = try await dataFetcher.fetchMovies(for: "movie")
            homeStatus = .success
        }catch{
            print(error)
            homeStatus = .failed(underlyingError: error)
        }
    }
}
