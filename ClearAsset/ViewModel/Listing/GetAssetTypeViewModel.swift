//
//  GetAssetTypeViewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 30/01/2021.
//

import Foundation

typealias GetAssetTypeCompletion = ([AssetType]?, Error?) -> Void

protocol GetAssetTypeProtocol {
    func getAssetType(completion: @escaping GetAssetTypeCompletion)
}

class GetAssetTypeViewModel {
    fileprivate var assetTypeService: GetAssetTypeServiceProtocol!
    init(assetTypeService: GetAssetTypeServiceProtocol = AssetTypeApi()) {
        self.assetTypeService = assetTypeService
    }
}

extension GetAssetTypeViewModel: GetAssetTypeProtocol {
    func getAssetType(completion: @escaping GetAssetTypeCompletion) {
        self.assetTypeService.getAssetTypes { (dataAsset, error) in
            if error == nil {
                guard let data = dataAsset?.data.types, !data.isEmpty else {
                    return                    
                }
                completion(data, nil)
                return
            } else {
                completion(nil, error)
                return
            }
        }
    }
}
