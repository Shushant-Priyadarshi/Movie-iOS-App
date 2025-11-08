//
//  VerticalListView.swift
//  MovieApp
//
//  Created by Shushant  on 08/11/25.
//

import SwiftUI

struct VerticalListView: View {
    var movies:[MovieModel]
    let onSelect: (MovieModel) -> Void
    
    var body: some View {
        List(movies){ movie in
            NavigationLink{
                MovieDetailView(MovieDetailData: movie)
            }label: {
                AsyncImage(url: URL(string: movie.posterPath ?? "")){image in
                    HStack {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(5)
                        
                        Text((movie.name ?? movie.title) ?? "Movie name")
                            .font(.system(size: 14))
                            .bold()
                    }
                    
                }placeholder:{
                    ProgressView()
                }
                .frame(height: 150)
                .onTapGesture {
                    onSelect(movie)
                }
            }
      
            
        }
    }
}

#Preview {
    VerticalListView(movies: MovieModel.previewMovies){_ in}
}
