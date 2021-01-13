//
//  GetCountryViewModel.swift
//  ClearAsset
//
//  Created by MohammadReza on 1/13/21.
//

import Foundation

typealias GetCountryCompletionHandlar = (AllCountry?, Error?) -> Void

protocol GetCountryProtocol {
    func getCountry(completion: @escaping GetCountryCompletionHandlar)
}

class GetCountryViewModel {
    var getCountryService: GetCountryServiceProtocol!
    init(getCountryService: GetCountryServiceProtocol = CountryApi()) {
        self.getCountryService = getCountryService
    }
}

extension GetCountryViewModel: GetCountryProtocol {
    func getCountry(completion: @escaping GetCountryCompletionHandlar) {
        getCountryService.getCountry { (countryData, error) in
            if error == nil {
                if let allCountry = countryData?.data {
                    completion(allCountry, nil)
                    return
                }
                return
            } else {
                completion(nil, error)
                return
            }
        }
    }
}
