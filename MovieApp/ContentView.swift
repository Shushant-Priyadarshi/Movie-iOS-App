//
//  ContentView.swift
//  MovieApp
//
//  Created by Shushant  on 27/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab(Constants.homeString,systemImage: Constants.homeIconString){
               HomeView()
            }
            
            Tab(Constants.upcomingString,systemImage: Constants.upcomingIconString){
                Text(Constants.upcomingString)
            }
            
            Tab(Constants.searchString,systemImage: Constants.searchIconString){
                Text(Constants.searchString)
            }
            
            Tab(Constants.downloadsString,systemImage: Constants.downloadIconString){
                Text(Constants.downloadsString)
            }
        }
        
    }
}


#Preview {
    ContentView()
}
