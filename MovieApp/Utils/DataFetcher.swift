//
//  DataFetcher.swift
//  MovieApp
//
//  Created by Shushant  on 29/10/25.
//

import Foundation


struct DataFetcher{
    let tmdbBaseURL = APIConfig.shared?.tmdbBaseURL
    let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey
    let youtubeSearchURL = APIConfig.shared?.youtubeSearchURL
    let youtubeAPIKey = APIConfig.shared?.youtubeAPIKey
    
    //https://api.themoviedb.org/3/trending/movie/day?api_key=YOUR_API_KEY //for trending movies
    //https://api.themoviedb.org/3/movie/top_rated?api_key=YOUR_API_KEY    //for top rated movies
    func fetchMovies(for media: String, by type:String) async throws -> [MovieModel]{
        
        guard let fetchURL =  try buildURL(media: media, type: type) else{
            throw NetworkError.urlBuildFailed
        }
        
        var movies = try await fetchAndDecode(url: fetchURL, type: TMDBAPIObject.self).results
        Constants.addPostPath(to: &movies)
        return movies
    }
    
    
    
    
    //function to build url for trending movie / top rated movie  and trending tv / top rated tv
    //media could be movie or tv
    private func buildURL(media:String,type:String) throws -> URL?{
        guard let baseURL = tmdbBaseURL else{
            throw NetworkError.missingConfig
        }
        
        guard let apiKey = tmdbAPIKey else{
            throw NetworkError.missingConfig
        }
        
        var path:String
        
        if type == "trending"{
            path = "3/trending/\(media)/day"
        }else if type == "top_rated"{
            path = "3/\(media)/top_rated"
        }else{
            throw NetworkError.urlBuildFailed
        }
        
        guard let url = URL(string: baseURL)?
            .appending(path: path)
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ])
        else{
            throw NetworkError.urlBuildFailed
        }
        
        return url
    }
    
    
    //fetch trailer of the movie provided
    func fetchVideoId(for movie:String) async throws -> String {
        guard let baseSearchURL  = youtubeSearchURL else{
            throw NetworkError.missingConfig
        }
        
        guard let searchAPIKey = youtubeAPIKey else{
            throw NetworkError.missingConfig
        }
        
        let trailerSearch = movie + YoutubeURLStrings.space.rawValue + YoutubeURLStrings.trailer.rawValue 
        
        guard let fetchVideoURL = URL(string: baseSearchURL)?.appending(queryItems: [
            URLQueryItem(name: YoutubeURLStrings.queryShorten.rawValue, value: trailerSearch),
            URLQueryItem(name: YoutubeURLStrings.key.rawValue, value: searchAPIKey)
        ])else{
            throw NetworkError.urlBuildFailed
        }
       
        return try await fetchAndDecode(url: fetchVideoURL, type: YoutubeSearchResponseModel.self).items?.first?.id?.videoId ?? ""
        
    }
    
    
    
    //generic function for fetching the url and parsing the json
    private func fetchAndDecode<T:Decodable>(url:URL, type: T.Type) async throws -> T{
        let (data,urlResponse) = try await URLSession.shared.data(from: url)
        
        guard let response = urlResponse as? HTTPURLResponse , response.statusCode == 200 else{
            throw NetworkError.badURLResponse(underlyingError: NSError(
                domain: "Datafetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1 ,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"]))
        }
        
        let decoder  = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from: data)
    }
    
}
