//
//  GetBrandListViewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 23/01/2021.
//

import Foundation

typealias GetBrandListCompletion = ([Brand]?, Error?) -> Void

protocol GetBrandListProtocol {
    func getBrandList(category id: Int?, completion: @escaping GetBrandListCompletion)
}

class GetBrandListViewModel {
    fileprivate var getBrandService: GetBrandListServiceProtocol!
    init(getBrandService: GetBrandListServiceProtocol = BrandApi()) {
        self.getBrandService = getBrandService
    }
}

extension GetBrandListViewModel: GetBrandListProtocol {
    func getBrandList(category id: Int?, completion: @escaping GetBrandListCompletion) {
        guard let catId = id else {return}
        let parameters = ["category" : catId]
        self.getBrandService.getBrand(parameter: parameters) { (list, error) in
            if error == nil {
                guard let brandlist = list?.data.brands, !brandlist.isEmpty else {
                    return
                }
                completion(brandlist, nil)
                return
            } else {
                completion(nil, error)
                return
            }
        }
    }
}
