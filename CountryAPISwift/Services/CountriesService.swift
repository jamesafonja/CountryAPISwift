//
//  Service.swift
//  CountryTest
//
//  Created by James Afonja on 5/25/23.
//

import Foundation

final class CountriesService: APIService {
    let url =  K.URLs.countriesURL
    var error: APIError?
    
    private init() {}
    static let shared = CountriesService()
}

extension CountriesService {
    func getData<T: Codable>(
        urlString: String,
        memberType: T.Type,
        completion: @escaping (_ data: T?, _ error: APIError?) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(nil, .badURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                error == nil
            else {
                completion(nil, self.apiError(from: response ?? URLResponse()))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData, nil)
            } catch {
                completion(nil, .decoderError)
            }
        }
        task.resume()
    }
}

