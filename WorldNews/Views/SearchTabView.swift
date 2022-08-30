//
//  SearchTabView.swift
//  WorldNews
//
//  Created by marco rodriguez on 30/08/22.
//

import SwiftUI

struct SearchTabView: View {
    
    @StateObject var searchVM = ArticleSearchViewModel()
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                
                .navigationTitle("Search")
        }
        .searchable(text: $searchVM.searchQuery)
        .onChange(of: searchVM.searchQuery) { newValue in
            if newValue.isEmpty {
                searchVM.phase = .empty
            }
        }
        .onSubmit(of: .search, search)
    }
    
    private var articles: [Article] {
        if case .success(let articles) = searchVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch searchVM.phase {
        case .empty:
            if !searchVM.searchQuery.isEmpty {
                ProgressView()
            } else {
                EmptyPlaceholderView(text: "Type your query to search from WorldNews", image: Image(systemName: "magnifyingglass"))
            }
            
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No search results found", image: Image(systemName: "magnifyingglass"))
            
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: search)
            
        default: EmptyView()
        }
    }
    
    private func search() {
        async {
            await searchVM.searchArticle()
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        SearchTabView()
    }
}
