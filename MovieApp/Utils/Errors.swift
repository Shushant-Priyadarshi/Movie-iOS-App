//
//  Errors.swift
//  MovieApp
//
//  Created by Shushant  on 29/10/25.
//

import Foundation

//MARK: - API configuration error handler

enum APIConfigError: Error, LocalizedError{
    case fileNotFound
    case dataLoadingFailed(underlyingError:Error)
    case decodingFailed(underlyingError:Error)
    
    
    var errorDescription: String?{
        switch self{
        case .fileNotFound:
            return "API Configuration file is not found"
            
        case .dataLoadingFailed(underlyingError: let error):
            return "Failed to load data from API Configuration file:  \(error.localizedDescription)"
            
        case .decodingFailed(underlyingError: let error):
            return "Failed to decode API configration: \(error.localizedDescription)"
        }
    }
}

//MARK: - Network error handler

enum NetworkError:Error, LocalizedError{
    case badURLResponse(underlyingError:Error)
    case missingConfig
    case urlBuildFailed
    
    var errorDescription: String?{
        switch self{
        case .badURLResponse(underlyingError: let error):
            return "Failed to parse URL response: \(error.localizedDescription)"
            
        case .missingConfig:
            return "Missing API Configuration"
            
        case .urlBuildFailed:
            return "Failed to build the URL"
        }
    }
    
}
