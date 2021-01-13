//
//  GetCurrencyViewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 11/01/2021.
//

import Foundation

protocol GetCurrencyListProtocol {
    func getCurrencyList(completion: @escaping GetCurrencyCompletion)
}

class GetCurrencyViewModel {
    
    fileprivate var getCurrencyService: GetCurrencyProtocol
    
    init(getCurrencyService: GetCurrencyProtocol = CurrencyApi()) {
        self.getCurrencyService = getCurrencyService
    }
    
}

extension GetCurrencyViewModel: GetCurrencyListProtocol {
    func getCurrencyList(completion: @escaping GetCurrencyCompletion) {
        getCurrencyService.getCurrency { (currencyList, error) in
            if error == nil {
                completion(currencyList, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
