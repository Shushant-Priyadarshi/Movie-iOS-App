//
//  UpcomingMovieView.swift
//  MovieApp
//
//  Created by Shushant  on 08/11/25.
//

import SwiftUI

struct UpcomingMovieView: View {
    @State private var moviePath = NavigationPath()
    var movieViewModel = MovieViewModel()
    
    var body: some View {
        NavigationStack(path: $moviePath) {
            GeometryReader{geo in
                switch movieViewModel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                case .success:
                    VerticalListView(movies: movieViewModel.upcomingMovies){ movie in
                        moviePath.append(movie)
                    }
                case .failed(let error):
                    Text("error: \(error.localizedDescription)")
                }
            }
            .task {
                await movieViewModel.getUpcomingMovies()
            }
            .navigationDestination(for: MovieModel.self) { movie in
                MovieDetailView(MovieDetailData: movie)
            }
        }
    }
    
}

#Preview {
    UpcomingMovieView()
}
