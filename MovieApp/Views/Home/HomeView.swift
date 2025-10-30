//
//  HomeView.swift
//  MovieApp
//
//  Created by Shushant  on 28/10/25.
//

import SwiftUI

struct HomeView: View {
    var heroTestTitle = Constants.testTitleURL
    var movieViewModel = MovieViewModel()
    
    var body: some View {
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
                    AsyncImage(url: URL(string: heroTestTitle)){ image in
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
                            
                        }label: {
                            Text(Constants.playString)
                                .myBtnStyle()
                            
                        }
                        
                        
                        Button{
                            
                        }label: {
                            Text(Constants.downloadsString)
                                .myBtnStyle()
                        }
                    }
                    
                    HorizontalListView(header: Constants.trendingMoviesString, titles: movieViewModel.trendingMovies)
                    HorizontalListView(header: Constants.trendingTVString,titles: movieViewModel.trendingTV)
                    HorizontalListView(header: Constants.topRatedMovieString,titles: movieViewModel.topRatedMovies)
                    HorizontalListView(header: Constants.topRatedTVString,titles: movieViewModel.topRatedTV)
                }
                
            case .failed(let error):
                Text("Error \(error.localizedDescription)")
            
            }
          
 
            }
            .task {
                await movieViewModel.getMoviesAndTvs()
            }
        }
    }
}

#Preview {
    HomeView()
}
