//
//  GetSectionViewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 30/01/2021.
//

import Foundation

typealias GetSectionCompletion = ([Section]?, Error?) -> Void

protocol GetSectionProtocol {
    func getSection(completion: @escaping GetSectionCompletion)
}

class GetSectionViewModel {
    fileprivate var sectionService: GetSectionServiceProtocol!
    init(sectionService: GetSectionServiceProtocol = SectionApi()) {
        self.sectionService = sectionService
    }
}

extension GetSectionViewModel: GetSectionProtocol {
    func getSection(completion: @escaping GetSectionCompletion) {
        sectionService.getSection { (data, error) in
            if error == nil {
                guard let sections = data?.data.sections, !sections.isEmpty else {
                    return
                }
                completion(sections, nil)
                return
            } else {
                completion(nil, error)
                return
            }
        }
    }
}
