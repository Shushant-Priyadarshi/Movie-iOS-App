//
//  Constants.swift
//  MovieApp
//
//  Created by Shushant  on 28/10/25.
//

import Foundation
import SwiftUI

struct Constants{
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let downloadsString = "Downloads"
    static let playString = "Play"
    static let trendingMoviesString = "Trending Movies"
    static let trendingTVString = "Trending TV"
    static let topRatedMovieString = "Top Rated Movies"
    static let topRatedTVString = "Top Rated TV"
    static let movieSearchString = "Movie Search"
    static let tvSearchString = "TV Search"
    static let movieSearchBarString = "Search for a Movie"
    static let tvSearchBarString = "Search for a TV show"
    
    static let homeIconString = "house"
    static let upcomingIconString = "play.circle"
    static let searchIconString = "magnifyingglass"
    static let downloadIconString = "arrow.down.to.line"
    static let movieSearchIconString = "movieclapper"
    static let tvSearchIconString = "tv"
    
    
    static let testTitleURL = "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg"
    static let testTitleURL2 = "https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg"
    static let testTitleURL3 = "https://image.tmdb.org/t/p/w500/nnl6OWkyPpuMm595hmAxNW3rZFn.jpg"
    
    static let postPathStart = "https://image.tmdb.org/t/p/w500"
    
    static func addPostPath(to movies: inout[MovieModel]){
        for index in movies.indices{
            if let path = movies[index].posterPath {
                movies[index].posterPath = Constants.postPathStart + path
            }
        }
    }
}

enum YoutubeURLStrings:String{
    case trailer = "trailer"
    case queryShorten = "q"
    case space = " "
    case key = "key"
}

extension Text{
    func myBtnStyle() -> some View{
        self
            .frame(width: 100 , height: 50)
            .foregroundStyle(.buttonText)
            .bold()
            .background{
                RoundedRectangle(cornerRadius:20, style: .continuous)
                    .stroke(.buttonBorder, lineWidth: 5)
            }
    }
}


extension Text{
    func errorMessageStyle() -> some View{
        self
            .foregroundStyle(.red)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 10))

    }
}

  
