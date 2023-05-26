//
//  APIService.swift
//  CountryTest
//
//  Created by James Afonja on 5/26/23.
//

import Foundation

protocol APIService {
    var error: APIError? { get set }
    var url: String { get }
    
    func getData<T: Codable>(
        urlString: String,
        memberType: T.Type,
        completion: @escaping (_ data: T?, _ error: APIError?) -> Void
    )
    
}

extension APIService {
    func apiError(from response: URLResponse) -> APIError? {
        guard let urlResponse = response as? HTTPURLResponse else { return .badRequest }
        
        switch urlResponse.statusCode {
        case 200..<300:
            return nil
        default:
            return .badResponse(statusCode: urlResponse.statusCode)
        }
    }
    
}

enum APIError: Error, CustomStringConvertible {
    case badRequest
    case badResponse(statusCode: Int)
    case badURL
    case decoderError
}

extension APIError {
    var description: String {
        switch self {
        case .badRequest:
            return "Error: Bad request"
        case .badResponse(let statusCode):
            return "Error: Bad response. Status code: \(statusCode)"
        case .badURL:
            return "Error: Bad URL"
        case .decoderError:
            return "Decoder error"
        }
    }
}


