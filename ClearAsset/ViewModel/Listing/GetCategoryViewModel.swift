//
//  GetCategoryViewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 23/01/2021.
//

import Foundation

typealias GetCategoryCompletion = (Categories?, Error?) -> Void

protocol GetCategoryProtocol {
    func getCategory(completion: @escaping GetCategoryCompletion)
}

class GetCategoryViewModel {
    var getCategoryService: GetCategoryServiceProtocol!
    init(getCategoryService: GetCategoryServiceProtocol = CategoryApi()) {
        self.getCategoryService = getCategoryService
    }
}

extension GetCategoryViewModel: GetCategoryProtocol {
    func getCategory(completion: @escaping GetCategoryCompletion) {
        getCategoryService.getCategory { (dataCategories, error) in
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
