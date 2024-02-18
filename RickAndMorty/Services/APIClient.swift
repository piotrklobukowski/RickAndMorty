//
//  APIClient.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 17/02/2024.
//

import Foundation

final class APIClient {
    func load<T: Decodable>(for type: T.Type, from url: URL) async -> Result<T, APIError> {
        do {
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(APIError.invalidServerResponse)
            }
            
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                return .failure(APIError.jsonDecodingFailed)
            }
            return .success(decodedData)
        } catch {
            return .failure(APIError.anotherError(error.localizedDescription))
        }
    }
}

enum APIError: LocalizedError {
    case invalidServerResponse
    case jsonDecodingFailed
    case anotherError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            return "Invalid server response"
        case .jsonDecodingFailed:
            return "JSON decoding failed"
        case .anotherError(let description):
            return description
        }
    }
}
