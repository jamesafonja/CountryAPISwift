//
//  CountryListViewModel.swift
//  CountryAPISwift
//
//  Created by James Afonja on 5/26/23.
//

import Foundation

// MARK: CountryListViewModel
final class CountryListViewModel: NSObject {
    
    var countries: [Country] = []
    var filteredCountries: [Country] = []
    let apiService: APIService
    
    init(service: APIService) {
        self.apiService = service
    }
}

extension CountryListViewModel {
    func getCountries(url: String = K.URLs.countriesURL ,completion: @escaping (_ countries: [Country], _ error: APIError?) -> Void) {
        apiService.getData(
            urlString: url,
            memberType: [Country].self
        ) { data, error in
            
            if let error = error {
                completion([], error)
            } else {
                completion(data ?? [], nil)
            }
            
        }
    }
}

extension CountryListViewModel {
    func nameAndRegion(for country: Country) -> String {
        country.name + " " + country.region.rawValue
    }
    
    func code(for country: Country) -> String {
        country.code
    }
    
    func capital(of country: Country) -> String {
        country.capital
    }
}

extension CountryListViewModel {
    
    func filterNameAndRegionArray(targetText: String, completionHandler: ([Country]) -> Void) {
        let filteredArray =  countries.filter { $0.name.lowercased().contains(targetText.lowercased()) || $0.region.rawValue.lowercased().contains(targetText.lowercased()) }
        
        completionHandler(filteredArray)
    }
}


extension CountryListViewModel {
    
    var finalCountryArray: [Country] {
        get {
            filteredCountries.isEmpty ? countries : filteredCountries
        }
        
        set {
            filteredCountries = newValue
        }
    }
    
}
