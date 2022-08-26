//
//  NewsTabView.swift
//  WorldNews
//
//  Created by marco rodriguez on 26/08/22.
//

import SwiftUI

struct NewsTabView: View {
    
    //Se crea una instancia del viewModel, por defecto la fase es .empty y al array de articles es nil
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .onAppear{
                    async {
                        //necesitamos que busque y cambie la fase
                        await articleNewsVM.loadArticles()
                    }
                }
                .navigationTitle(articleNewsVM.selectedCategory.text)
        }
    }
    
    //Esta funcion determina si la fase es .success, returna el array de articles
    private var articles: [Article] {
        if case let .success(articles) = articleNewsVM.phase {
            return articles
        } else {
            return []
        }
    }
    
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(articleNewsVM: ArticleNewsViewModel(articles: Article.previewData))
    }
}
