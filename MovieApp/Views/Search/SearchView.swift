//
//  SearchView.swift
//  MovieApp
//
//  Created by Shushant  on 08/11/25.
//

import SwiftUI

struct SearchView: View {
    var movies:[MovieModel]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]){
                ForEach(movies){movie in
                    AsyncImage(url: URL(string: movie.posterPath ?? "")){ image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 10))
                    }placeholder: {
                        ProgressView()
                    }
                    .frame(width: 120,height: 200)
                }
              
            }
        }
    }
}

#Preview {
    SearchView(movies: MovieModel.previewMovies)
}

