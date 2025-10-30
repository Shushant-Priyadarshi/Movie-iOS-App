//
//  HorizontalListView.swift
//  MovieApp
//
//  Created by Shushant  on 28/10/25.
//

import SwiftUI

struct HorizontalListView: View {
    
    let header:String
    var titles:[String] = [Constants.testTitleURL,Constants.testTitleURL2,Constants.testTitleURL3]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .font(.title)
            
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(titles , id:\.self){ title in
                        AsyncImage(url: URL(string: title)){image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120,height: 200)
                            
                    }
                }
            }
        }
        .frame(height: 250)
        .padding()
    }
}

#Preview {
    HorizontalListView(header: Constants.trendingMoviesString)
}
