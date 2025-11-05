//
//  YoutubePlayer.swift
//  MovieApp
//
//  Created by Shushant  on 30/10/25.

import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable{ //let us use uikit using swiftui
    let webView = WKWebView() //create an instance of the browser inside the app
    let videoId:String
    let youtubeBaseURL = APIConfig.shared?.youtubeBaseURL
    
    func makeUIView(context: Context) -> some UIView {
        webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let baseURLString = youtubeBaseURL,               //checks if the youtube url is present
              let baseURL = URL(string: baseURLString) else{    //conert the string -> URL
            return
        }
        let bundleId = Bundle.main.bundleIdentifier ?? "com.movieapp"
        let referer = "https://\(bundleId)"
        
        let fullURL = baseURL.appendingPathComponent(videoId)
        
        var request = URLRequest(url: fullURL)
        request.setValue(referer, forHTTPHeaderField: "Referer")
        webView.load(request)
    }
    
}
