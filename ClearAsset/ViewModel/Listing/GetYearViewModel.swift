//
//  GetYearViewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 31/01/2021.
//

import Foundation

typealias GetYearCompletion = (String?, Error?) -> Void

protocol GetYearProtocol {
    func getYear(completion: @escaping GetYearCompletion)
}

class GetYearViewModel {
    fileprivate var service: GetYearServiceProtocol!
    init(service: GetYearServiceProtocol = YearApi()) {
        self.service = service
    }
}

extension GetYearViewModel: GetYearProtocol {
    func getYear(completion: @escaping GetYearCompletion) {
        service.getStartYear { (dataYear, error) in
            if error == nil {
                guard let year = dataYear?.data.year, !year.isEmpty else {
                    return
                }
                completion(year, nil)
            } else {
                completion(nil, error)
                return
            }
        }
    }
}
