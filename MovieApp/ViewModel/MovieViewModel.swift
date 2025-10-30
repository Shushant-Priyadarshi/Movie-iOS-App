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
    private(set) var videoIdStatus:FetchStatus = .notStarted
    
    private let dataFetcher = DataFetcher()
    
    var trendingMovies: [MovieModel] = []
    var trendingTV: [MovieModel] = []
    var topRatedMovies: [MovieModel] = []
    var topRatedTV: [MovieModel] = []
    var videoId:String = ""
    
    var heroMovie:MovieModel = MovieModel.previewMovies[0]
    
    func getMoviesAndTvs() async{
        homeStatus = .fetching
        
        if trendingMovies.isEmpty{
            do{
                async let tMovies =  dataFetcher.fetchMovies(for: "movie",by: "trending")
                async let tTV = dataFetcher.fetchMovies(for: "tv", by: "trending")
                async let tRMovies = dataFetcher.fetchMovies(for: "movie", by: "top_rated")
                async let tRTV = dataFetcher.fetchMovies(for: "tv", by: "top_rated")
                
                trendingMovies = try await tMovies
                trendingTV = try await tTV
                topRatedMovies = try await tRMovies
                topRatedTV = try await tRTV
                if let randomMovie = trendingMovies.randomElement(){
                    heroMovie = randomMovie
                }
                homeStatus = .success
            }catch{
                print(error)
                homeStatus = .failed(underlyingError: error)
            }
        }else{
            homeStatus = .success
        }
    }
    
    func getVideoId(for movie:String) async {
        videoIdStatus = .fetching
        
        do{
            videoId = try await dataFetcher.fetchVideoId(for: movie)
            videoIdStatus = .success
        }catch{
            print(error)
            videoIdStatus = .failed(underlyingError: error)
        }
    }
}
