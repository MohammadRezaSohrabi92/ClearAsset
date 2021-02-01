//
//  SaveImageApi.swift
//  ClearAsset
//
//  Created by Peyk Office on 31/01/2021.
//

import Foundation
import Alamofire

typealias SaveImageServiceCompletion = (DataImage?, ErrorMessageModel?) -> Void

protocol SaveImageServiceProtocol {
    func saveImage(imageData: Data?, completion: @escaping SaveImageServiceCompletion)
}

class SaveImageApi: BaseSDK {
    let saveImageURL = "listing/image"
}

extension SaveImageApi: SaveImageServiceProtocol {
    func saveImage(imageData: Data?, completion: @escaping SaveImageServiceCompletion) {
        let headers : HTTPHeaders = [.accept(acceptJson), .contentType(multipartContentType), .contentDisposition(multipartContentDisposition), .authorization(bearerToken: Utility().getToken())]
        let params = ["pic" : ""]
        NetworkingClient.shared.uploadFile(makeURL(url: saveImageURL), file: imageData, parameter: params, headers: headers) { (data, error, uploadError) in
            if uploadError != nil {
                completion(nil, ErrorMessageModel(title: "", message: uploadError!, code: 10))
                return
            } else if error == nil {
                do {
                    if let mData = data {
                        let decoded = try self.decoder.decode(DataImage.self, from: mData)
                        completion(decoded, nil)
                        return
                    }
                } catch {
                    print(self.failedJson)
                    return
                }
            } else {
                completion(nil, ErrorMessageModel(title: "", message: error!.localizedDescription, code: nil))
                return
            }
        }
    }
}
