//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Shushant  on 30/10/25.
//

import SwiftUI

struct MovieDetailView: View {
    let MovieDetailData:MovieModel
    var titleName:String{
        return (MovieDetailData.name ?? MovieDetailData.title) ?? ""
    }
    
    let movieViewModel = MovieViewModel()
    
    var body: some View {
        GeometryReader{ geo in
            switch movieViewModel.videoIdStatus {
                
            case .notStarted:
                EmptyView()
                
            case .fetching:
                ProgressView()
                    .frame(width: geo.size.width, height: geo.size.height)
                
            case .success:
                ScrollView{
                    LazyVStack(alignment: .leading) {
                        
                        YoutubePlayer(videoId: movieViewModel.videoId)
                            .aspectRatio(1.3,contentMode: .fit)
                        
                        Text(titleName)
                            .bold()
                            .font(.title2)
                            .padding(5)
                        
                        Text(MovieDetailData.overview ?? "")
                            .padding(5)
                    }
                }
            case .failed(let underlyingError):
                Text(underlyingError.localizedDescription)
            }
        }
        .task {
           await movieViewModel.getVideoId(for: titleName)
        }
    }
}

#Preview {
    MovieDetailView(MovieDetailData: MovieModel.previewMovies[0])
}
