//
//  VerticalListView.swift
//  MovieApp
//
//  Created by Shushant  on 08/11/25.
//

import SwiftUI
import SwiftData

struct VerticalListView: View {
    var movies:[MovieModel]
    let canDelete:Bool
    @Environment(\.modelContext) var modelContext
    
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
            }
            .swipeActions(edge: .trailing) {
                Button {
                    modelContext.delete(movie)
                    try? modelContext.save()
                } label: {
                    Image(systemName: "trash")
                        .tint(.red)
                }

            }
      
            
        }
    }
}

#Preview {
    VerticalListView(movies: MovieModel.previewMovies, canDelete: true)
}
