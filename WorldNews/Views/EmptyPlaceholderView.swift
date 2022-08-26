//
//  EmptyPlaceholderView.swift
//  WorldNews
//
//  Created by marco rodriguez on 26/08/22.
//

import SwiftUI

struct EmptyPlaceholderView: View {
    let text : String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8){
            Spacer()
            if let image = self.image{
                image.imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}

struct EmptyPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPlaceholderView(text: "No Bookmarkcs", image: Image(systemName: "bookmark"))
    }
}
