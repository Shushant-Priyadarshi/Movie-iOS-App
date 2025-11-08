//
//  SearchView.swift
//  MovieApp
//
//  Created by Shushant  on 08/11/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchByMovie = true
    @State private var searchText = ""
    private var searchViewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()

    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView{
                if let errorMessage = searchViewModel.errorMessage{
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
                LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]){
                    ForEach(searchViewModel.searchTitle){movie in
                        AsyncImage(url: URL(string: movie.posterPath ?? "")){ image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 10))
                        }placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120,height: 200)
                        .onTapGesture {
                            navigationPath.append(movie)
                        }
                    }
                    
                }
            }
            .navigationTitle(searchByMovie ? Constants.movieSearchString : Constants.tvSearchString)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        searchByMovie.toggle()
                        Task{
                            await searchViewModel.getSearchedMovieOrTV(by: searchByMovie ? "movie" : "tv", for: searchText)
                        }
                    } label: {
                        Image(systemName: searchByMovie ?  Constants.movieSearchIconString : Constants.tvSearchIconString)
                    }

                }
            }
            .searchable(text: $searchText, prompt: searchByMovie ? Constants.movieSearchBarString : Constants.tvSearchBarString)
            .task(id: searchText) {
                try? await Task.sleep(for: .milliseconds(500))
                
                if Task.isCancelled{
                    return
                }
                
                await searchViewModel.getSearchedMovieOrTV(by: searchByMovie ? "movie" : "tv", for: searchText)
            }
            .navigationDestination(for: MovieModel.self) { movie in
                MovieDetailView(MovieDetailData: movie)
            }
        }
        
    }
}

#Preview {
    SearchView()
}

