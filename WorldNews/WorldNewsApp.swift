//
//  WorldNewsApp.swift
//  WorldNews
//
//  Created by marco rodriguez on 24/08/22.
//

import SwiftUI

@main
struct WorldNewsApp: App {
    
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
