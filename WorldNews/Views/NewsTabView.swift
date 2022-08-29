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
                .overlay(overlayView)
                .task(id: articleNewsVM.fetchTaskToken, loadTask)
                .refreshable(action: refreshTask)
//                .onAppear{
//                   loadTask()
//                }
//                .onChange(of: articleNewsVM.selectedCategory) { _ in
//                 loadTask()
//                }
                .navigationTitle(articleNewsVM.fetchTaskToken.category.text)
                .navigationBarItems(trailing: menu)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsVM.phase {
        case .empty:
            ProgressView()
            
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No Articles available", image: nil)
            
        case .failure(let error):
             RetryView(text: error.localizedDescription, retryAction: refreshTask)
        default:
            EmptyView()
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
    
    private func loadTask() async {
        await articleNewsVM.loadArticles()
    }
    
    private func refreshTask() {
        articleNewsVM.fetchTaskToken = FetchTaskToken(category: articleNewsVM.fetchTaskToken.category, token: .now)
    }
    
    private var menu: some View {
        Menu {
            Picker("Category", selection: $articleNewsVM.fetchTaskToken.category) {
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
        }
    }
    
}

struct NewsTabView_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel()
    
    static var previews: some View {
        NewsTabView(articleNewsVM: ArticleNewsViewModel(articles: Article.previewData))
            .environmentObject(articleBookmarkVM)
    }
}
