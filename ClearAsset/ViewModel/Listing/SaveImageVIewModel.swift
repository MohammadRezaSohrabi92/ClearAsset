//
//  SaveImageVIewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 01/02/2021.
//

import Foundation

typealias SaveImageCompletion = (ImageModel?, ErrorMessageModel?) -> Void

protocol SaveImageProtocol {
    func saveImage(imageData: Data?, completion: @escaping SaveImageCompletion)
}

class SaveImageViewModel {
    fileprivate var service: SaveImageServiceProtocol!
    init(service: SaveImageServiceProtocol = SaveImageApi()) {
        self.service = service
    }
}

extension SaveImageViewModel: SaveImageProtocol {
    func saveImage(imageData: Data?, completion: @escaping SaveImageCompletion) {
        if let data = imageData {
            service.saveImage(imageData: data) { (dataImage, error) in
                if error == nil {
                    if let address = dataImage?.data {
                        completion(address, nil)
                        return
                    }
                } else {
                    completion(nil, error)
                    return
                }
            }
        }
    }
}
