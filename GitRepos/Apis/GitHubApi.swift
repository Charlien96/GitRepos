//
//  GitHubApi.swift
//  GitRepos
//
//  Created by Admin on 11/04/2022.
//

import Foundation


protocol GitHubApiType {
    func search(with request: SearchLanguageRequest, completion:@escaping((Result<SearchRepositoriesResponse, ApiError>) -> Void))
}

struct SearchLanguageRequest: Request {
    private let baseUrl = "https://api.github.com"

    var url: String {
        return baseUrl + "/search/repositories"
    }
    let language: String
    let page: Int
    
    func params() -> [(key: String, value: String)] {
        return [
            (key: "q", value: language),
            (key: "sort", value : "stars"),
            (key: "page", value : "\(page)")
        ]
    }
}

struct GitHubApi: GitHubApiType {
  
    func search(with request: SearchLanguageRequest, completion: @escaping((Result<SearchRepositoriesResponse, ApiError>) -> Void)) {
       
        ApiTask().request(.get, request: request) { (data, session) in
            do {
                let response = try self.parse(data)
                completion(.success(response))
            } catch {
                completion(.failure(ApiError.failedParse))
            }
        } onError: { error in
            completion(.failure(ApiError.recieveNilResponse))
        }
    }
    
    private func parse(_ data: Data) throws -> SearchRepositoriesResponse {
        let response: SearchRepositoriesResponse = try JSONDecoder().decode(SearchRepositoriesResponse.self, from: data)
        return response
    }
}
