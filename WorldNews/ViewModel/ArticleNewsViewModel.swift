//
//  ArticleNewsViewModel.swift
//  WorldNews
//
//  Created by marco rodriguez on 26/08/22.
// This VM will be observable and will be the conection between View and Model

import SwiftUI

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

@MainActor //all state mutations will be in the main threat its similar to DispatchQueue
//it will be an observable object to say the view if it need be upgraded
class ArticleNewsViewModel: ObservableObject {
   
    //By default is .empty and only will be .succes once the data will be ready
    @Published var phase = DataFetchPhase<[Article]>.empty
    
    @Published var selectedCategory: Category
    private let newsAPI = NewsAPI.shared //Singleton Instance
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        //safe unwrapp the articles, if when this class will be created it receive an array of articles
        if let articles = articles {
            
            //actualiza la fase y le pone los articulos
            self.phase = .success(articles) //change the phase of the fetch
        } else {
            self.phase = .empty
        }
        self.selectedCategory = selectedCategory
    }
    
    //actualiza la fase con los articulos listos
    func loadArticles() async {
        phase = .empty //this will clean the UI
        
        do {
            let articles = try await newsAPI.fetch(from: selectedCategory)
            phase = .success(articles)
        } catch  {
            phase = .failure(error)
        }
    }
    
    
}
