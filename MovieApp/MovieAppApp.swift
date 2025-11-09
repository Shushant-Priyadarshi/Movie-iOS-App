//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Shushant  on 27/10/25.
//

import SwiftUI
import SwiftData

@main
struct MovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: MovieModel.self)
    }
}
