//
//  NewsAPI.swift
//  WorldNews
//
//  Created by marco rodriguez on 24/08/22.
// https://www.youtube.com/watch?v=LRnbFjq0bTM continue at 1:47:00 -> Save Bookmark locally
 
import Foundation

struct NewsAPI {
    //SINGLETON solo permite crear un unica instancia de este NewsAPI
    static let shared = NewsAPI()
    private init() { }
    
    private let apiKey = "f0797ef3b62d4b90a400ed224e0f82b7" //f0797ef3b62d4b90a400ed224e0f82b7
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    
    //Fetch the data and return an array of articles
    func fetch(from category: Category) async throws -> [Article] {
        let url = generateNewsURL(from: category)
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode {
        
        case (200...299), (400...499):
            let apiResponse = try jsonDecoder.decode(NewsAPIResponse.self, from: data)
            if apiResponse.status == "ok" {
                return apiResponse.articles ?? []
            } else {
                throw generateError(description: apiResponse.message ?? "An error occured")
            }
            
        default:
            throw generateError(description: "An server error occured")
        }
    }
        private func generateError(code: Int = 1, description: String) -> Error {
            NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
        }
        
    //This function returns a url valid dependig of each category
    private func generateNewsURL(from category: Category) -> URL {
        var url = "https://newsapi.org/v2/top-headlines?"
        url += "apiKey=\(apiKey)"
        url += "&language=es"
        url += "&category=\(category.rawValue)"
        return URL(string: url)!
    }
    
}
