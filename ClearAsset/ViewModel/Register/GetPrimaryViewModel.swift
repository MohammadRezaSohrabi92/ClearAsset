//
//  GetPrimaryViewModel.swift
//  ClearAsset
//
//  Created by MohammadReza on 1/13/21.
//

import Foundation

typealias GetPrimaryCompletion = (Primary?, Error?) -> Void

protocol GetPrimaryProtocol {
    func getPrimary(completion: @escaping GetPrimaryCompletion)
}

class GetPrimaryViewModel {
    var getPrimaryService: GetPrimaryIndustryServiceProtocol!
    init(getPrimaryServicce: GetPrimaryIndustryServiceProtocol = PrimaryIndustryApi()) {
        self.getPrimaryService = getPrimaryServicce
    }
}

extension GetPrimaryViewModel: GetPrimaryProtocol {
    func getPrimary(completion: @escaping GetPrimaryCompletion) {
        getPrimaryService.getPrimary { (primaryData, error) in
            if error == nil {
                if let data = primaryData?.data {
                    completion(data, nil)
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
