//
//  ContentView.swift
//  WorldNews
//
//  Created by marco rodriguez on 24/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ArticleListView(articles: Article.previewData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
