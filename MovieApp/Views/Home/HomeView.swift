//
//  HomeView.swift
//  MovieApp
//
//  Created by Shushant  on 28/10/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    var movieViewModel = MovieViewModel()
    @State private var movieDetailPath = NavigationPath()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack(path: $movieDetailPath) {
            GeometryReader { geo in
                ScrollView {
                    switch movieViewModel.homeStatus{
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width: geo.size.width, height: geo.size.height)
                        
                    case .success:
                        LazyVStack{
                            AsyncImage(url: URL(string: movieViewModel.heroMovie.posterPath ?? "")){ image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .overlay {
                                        LinearGradient(
                                            stops: [
                                                Gradient.Stop(color: .clear, location: 0.8),
                                                Gradient.Stop(color: .gradient, location:1)
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: geo.size.width , height: geo.size.height * 0.85)
                            
                            HStack{
                                Button{
                                    movieDetailPath.append(movieViewModel.heroMovie)
                                }label: {
                                    Text(Constants.playString)
                                        .myBtnStyle()
                                    
                                }
                                
                                
                                Button{
                                    modelContext.insert(movieViewModel.heroMovie)
                                    try? modelContext.save()
                                }label: {
                                    Text(Constants.downloadsString)
                                        .myBtnStyle()
                                }
                            }
                            
                            HorizontalListView(header: Constants.trendingMoviesString, titles: movieViewModel.trendingMovies){ title in
                                movieDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.trendingTVString,titles: movieViewModel.trendingTV){ title in
                                movieDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedMovieString,titles: movieViewModel.topRatedMovies){ title in
                                movieDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedTVString,titles: movieViewModel.topRatedTV){ title in
                                movieDetailPath.append(title)
                            }
                        }
                       
                        
                    case .failed(let error):
                        Text(error.localizedDescription)
                            .errorMessageStyle()
                            .frame(width: geo.size.width, height: geo.size.height)
                        
                    }
                    
                    
                }
                .task {
                    await movieViewModel.getMoviesAndTvs()
                }
                .navigationDestination(for: MovieModel.self) { movie in
                    MovieDetailView(MovieDetailData: movie)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
