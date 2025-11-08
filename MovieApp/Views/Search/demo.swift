//
//  demo.swift
//  MovieApp
//
//  Created by Shushant  on 08/11/25.
//

import SwiftUI

struct demo: View {
    var body: some View {
        NavigationStack {
            Text("Hello World")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add") {
                            print("Add tapped")
                        }
                    }
                }
                .navigationTitle("Home bb")
        }
    }
}

#Preview {
    demo()
}
