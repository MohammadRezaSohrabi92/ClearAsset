//
//  NetworkValidationProtocol.swift
//  ClearAsset
//
//  Created by Peyk Office on 09/01/2021.
//

import Foundation

typealias HandleResponseCompletationHandler<T> = ((NetworkValidationResponse<T>) -> Void)

/// T is generic type
/// isSuccess : if service response error not nil = true, other false
/// errorMessage: show this message on ui
struct NetworkValidationResponse<T> {
    let responseModel: T?
    let isSuccess: Bool
    let errors: [Errors]?
    let errorMessage: String
    let errorCode: Int?
}

protocol NetworkValidationProtocol {
    func handleResponse<T>(responseModel: T?, error: Error?, completationHandler: @escaping HandleResponseCompletationHandler<T>)
}

extension NetworkValidationProtocol {
    func handleResponse<T>(responseModel: T?, error: Error?, completationHandler: @escaping HandleResponseCompletationHandler<T>) {
        if error == nil {
            completationHandler(NetworkValidationResponse<T>(responseModel: responseModel, isSuccess: true, errors: nil, errorMessage: "", errorCode: nil))
            return
        }
        if let networkError = error as? URLError {
            if networkError.code == .notConnectedToInternet || networkError.code == .networkConnectionLost {
                completationHandler(NetworkValidationResponse<T>(responseModel: nil, isSuccess: false, errors: [], errorMessage: "internet-connection-error".getString(), errorCode: 1009))
                return
            }
        }

        if let err = error as? ErrorResponse {

            switch err {
            case .error(let statusCode, let data, let info):
                do {
                    if let networkError = info as? URLError {
                        if networkError.code == .notConnectedToInternet || networkError.code == .networkConnectionLost {
                            completationHandler(NetworkValidationResponse<T>(responseModel: nil, isSuccess: false, errors: [], errorMessage: "internet-connection-error".getString(), errorCode: 1009))
                            return
                        }
                        return
                    }
                    let errorModelResp = try JSONDecoder().decode(ErrorModel.self, from: data ?? Data() )
                    handleStatusCode(statusCode: statusCode)
                    if let message = errorModelResp.message, !message.isEmpty {
                        completationHandler(NetworkValidationResponse<T>(responseModel: nil, isSuccess: false, errors: errorModelResp.errors, errorMessage: message, errorCode: statusCode))
                    } else {
                        completationHandler(NetworkValidationResponse<T>(responseModel: nil, isSuccess: false, errors: errorModelResp.errors, errorMessage: "server-unreachable".getString(),
                                                                         errorCode: statusCode))
                    }
                } catch let error {
                    completationHandler(NetworkValidationResponse<T>(responseModel: nil, isSuccess: false, errors: nil, errorMessage: "", errorCode: nil))
                    debugPrint(error)
                }
            }
        } else {
            completationHandler(NetworkValidationResponse<T>(responseModel: nil, isSuccess: false, errors: nil, errorMessage: "server-unreachable".getString(), errorCode: nil))
        }
    }
    fileprivate func handleStatusCode(statusCode: Int) {
        switch statusCode {
        case 500:
            print("Server Error")
        case 401:
            print("Uthentication Error")
        default:
            print("Unknown Error")
        }
    }
}
