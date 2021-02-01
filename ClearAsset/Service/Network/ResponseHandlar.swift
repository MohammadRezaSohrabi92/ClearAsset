////
////  ResponseHandlar.swift
////  ClearAsset
////
////  Created by Peyk Office on 31/01/2021.
////
//
//import Foundation
//import Alamofire
//
////typealias HandleResponseCompletationHandler = ((Codable) -> Void)
////
////protocol NetworkResponseProtocol {
////    func handleResponse<T>(data: Data?, responseModel: T.Type, completationHandler: @escaping HandleResponseCompletationHandler)
////}
//
//class ResponseHandlar {
//
//    let decoder = JSONDecoder()
//
//    func handlar<T : Codable>(data: Data?, responseModel: T.Type ) throws -> T where T : Decodable {
//        do {
//            if let mData = data {
//                let decoded = try decoder.decode(responseModel, from: mData)
//                return decoded
//            }
//        } catch {
//            print("Faild to decode JSON")
//        }
//        return
//    }
//
//}
//
////extension ResponseHandlar: NetworkResponseProtocol {
////    func handleResponse<T>(data: Data?, responseModel: T.Type, completationHandler: @escaping HandleResponseCompletationHandler) {
////        do {
////            if let mData = data {
////                let decoded = try decoder.decode(responseModel, from: mData)
////                completationHandler(decoded)
////            }
////        } catch {
////            print("Faild to decode ♥♥♥ JSON")
////        }
////    }
////}
