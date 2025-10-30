//
//  HomeView.swift
//  MovieApp
//
//  Created by Shushant  on 28/10/25.
//

import SwiftUI

struct HomeView: View {
    var heroTestTitle = Constants.testTitleURL
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
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
                    
                    HorizontalListView(header: Constants.trendingMoviesString)
                    HorizontalListView(header: Constants.trendingTVString)
                    HorizontalListView(header: Constants.trendingMoviesString)
                    HorizontalListView(header: Constants.topRatedTVString)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
