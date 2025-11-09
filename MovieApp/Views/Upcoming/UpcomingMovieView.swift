//
//  UpcomingMovieView.swift
//  MovieApp
//
//  Created by Shushant  on 08/11/25.
//

import SwiftUI

struct UpcomingMovieView: View {
    var movieViewModel = MovieViewModel()
    
    var body: some View {
        NavigationStack{
            GeometryReader{geo in
                switch movieViewModel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                case .success:
                    VerticalListView(movies: movieViewModel.upcomingMovies,canDelete: false)
                case .failed(let error):
                    Text("error: \(error.localizedDescription)")
                        .errorMessageStyle()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .task {
                await movieViewModel.getUpcomingMovies()
            }

        }
    }
    
}

#Preview {
    UpcomingMovieView()
}
