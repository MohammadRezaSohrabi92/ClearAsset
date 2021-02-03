//
//  GetSubCategoryViewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 23/01/2021.
//

import Foundation

typealias GetSubCategoryCompletion = (Categories?, Error?) -> Void

protocol GetSubCategoryProtocol {
    func getSubCategory(id: String, completion: @escaping GetSubCategoryCompletion)
}

class GetSubCategoryViewModel {
    var getSubCategoryService: GetSubCategoryServiceProtocol!
    init(getSubCategoryService: GetSubCategoryServiceProtocol = SubCategoryApi()) {
        self.getSubCategoryService = getSubCategoryService
    }
}

extension GetSubCategoryViewModel: GetSubCategoryProtocol {
    func getSubCategory(id: String, completion: @escaping GetSubCategoryCompletion) {
        getSubCategoryService.getSubCategory(id: id) { (dataCategories, error) in
            if error == nil {
                if let categories = dataCategories?.data {
                    completion(categories, nil)
                    return
                }
            } else {
                completion(nil, error)
            }
        }
    }
}
