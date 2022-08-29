//
//  ArticleBookmarkViewModel.swift
//  WorldNews
//
//  Created by marco rodriguez on 29/08/22.
//

import Foundation

@MainActor
class ArticleBookmarkViewModel: ObservableObject {
    @Published private(set) var bookmarks: [Article] = []
    
    //Checar el status del marcador, agregar o quitarlo
    func isBookmarked(for article: Article) -> Bool {
        //verifica que el articulo exista en el array del marcador
        bookmarks.first { article.id == $0.id } != nil
    }
    
    func addBookmark(for article : Article) {
        //verificamos si es un marcador, para agregarlo al listado
        guard !isBookmarked(for: article) else { return }
        
        bookmarks.insert(article, at: 0)
    }
    
    func removeBookmark(for article: Article) {
        
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else { return }
        
        bookmarks.remove(at: index)
    }
}
