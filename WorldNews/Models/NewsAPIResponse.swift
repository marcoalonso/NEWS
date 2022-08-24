//
//  NewsAPIResponse.swift
//  WorldNews
//
//  Created by marco rodriguez on 24/08/22.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
    
}
