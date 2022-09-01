//
//  ComingSoonView.swift
//  WorldNews
//
//  Created by marco rodriguez on 31/08/22.
//

import SwiftUI

struct ComingSoonView: View {
    var body: some View {
        VStack {
            Text("New feature of Weather coming soon")
                .font(.system(size: 29))
                .fontWeight(.bold)
                .foregroundColor(.blue)
            Image("weather")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .padding()
            Spacer()
        }
        
    }
}

struct ComingSoonView_Previews: PreviewProvider {
    static var previews: some View {
        ComingSoonView()
    }
}
