//
//  DownloadView.swift
//  MovieApp
//
//  Created by Shushant  on 09/11/25.
//

import SwiftUI
import SwiftData

struct DownloadView: View {
    @Query(sort: \MovieModel.title) var savedMovieOrTv: [MovieModel]
    var body: some View {
        NavigationStack{
           
            if savedMovieOrTv.isEmpty{
                Text("No Downloads")
                    .padding()
                    .font(.title3)
                    .bold()
            }else{
               VerticalListView(movies: savedMovieOrTv, canDelete: true)
            }
            
            
        }
    }
}

#Preview {
    DownloadView()
}
