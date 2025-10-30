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
    
    //https://api.themoviedb.org/3/trending/movie/day?api_key=YOUR_API_KEY
    func fetchMovies(for media: String) async throws -> [MovieModel]{
        guard let baseURL = tmdbBaseURL else{
            throw NetworkError.missingConfig
        }
        
        guard let apiKey = tmdbAPIKey else{
            throw NetworkError.missingConfig
        }
        
        guard let fetchMoviesURL = URL(string: baseURL)?
            .appending(path: "3/trending/\(media)/day")
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ])
        else{
            throw NetworkError.urlBuildFailed
        }
        
        print("DEBUG: \(fetchMoviesURL)")
        
        
        let (data,urlResponse) = try await URLSession.shared.data(from: fetchMoviesURL)
        
        guard let response = urlResponse as? HTTPURLResponse , response.statusCode == 200 else{
            throw NetworkError.badURLResponse(underlyingError: NSError(
                domain: "Datafetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1 ,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"]))
        }
        
        let decoder  = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(APIObject.self, from: data).results
    }
    
}
