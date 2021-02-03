//
//  GetModelListViewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 30/01/2021.
//

import Foundation

typealias GetModelListCompletion = ([Model]?, Error?) -> Void

protocol GetModelListProtocol {
    func getModel(brandId id: Int?, completion: @escaping GetModelListCompletion)
}

class GetModelListViewModel {
    fileprivate var modelService: GetModelServiceProtocol!
    init(modelService: GetModelServiceProtocol = ModelApi()) {
        self.modelService = modelService
    }
}

extension GetModelListViewModel: GetModelListProtocol {
    func getModel(brandId id: Int?, completion: @escaping GetModelListCompletion) {
        guard let brandId = id else {return}
        let parameter = ["brand": brandId]
        self.modelService.getModel(parameter: parameter) { (dataModel, error) in
            if error == nil {
                guard let models = dataModel?.data.models, !models.isEmpty else {
                    return
                }
                completion(models, nil)
                return
            } else {
                completion(nil, error)
                return
            }
        }
    }
}
