//
//  BookmarkTabView.swift
//  WorldNews
//
//  Created by marco rodriguez on 29/08/22.
//

import SwiftUI

struct BookmarkTabView: View {
    
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articleBookmarkVM.bookmarks)
                .overlay(overlayView(isEmpty: articleBookmarkVM.bookmarks.isEmpty))
                .navigationTitle("Saved Articles")
        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No Saved articles", image: Image(systemName: "bookmark"))
        }
    }
}

struct BookmarkTabView_Previews: PreviewProvider {
    
//    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel().shared
    
    static var previews: some View {
        BookmarkTabView()
            //.environmentObject(articleBookmarkVM)
    }
}
