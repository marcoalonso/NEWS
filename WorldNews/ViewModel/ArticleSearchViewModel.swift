//
//  ArticleSearchViewModel.swift
//  WorldNews
//
//  Created by marco rodriguez on 30/08/22.
//

import SwiftUI

@MainActor
class ArticleSearchViewModel: ObservableObject {
    
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
    private let newsAPI = NewsAPI.shared //singleton
    
    func searchArticle() async {
        
        if Task.isCancelled { return }
        
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let articles = try await newsAPI.search(for: searchQuery)
            phase = .success(articles)
        } catch  {
            if Task.isCancelled { return }
            phase = .failure(error)
        }
    }
    
}
