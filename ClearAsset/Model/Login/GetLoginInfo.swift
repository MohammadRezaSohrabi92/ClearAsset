//
//  GetLoginInfo.swift
//  ClearAsset
//
//  Created by Peyk Office on 18/01/2021.
//

import Foundation


struct DataGetLoginInfoModel: Codable {
    let data: GetLoginInfoModel
}

struct GetLoginInfoModel: Codable {
    let token, expiredAt: String
    let userInformation: UserInformation

    enum CodingKeys: String, CodingKey {
        case token
        case expiredAt = "expired_at"
        case userInformation = "user_information"
    }
}

struct UserInformation: Codable {
    let fullName, avatar, email, mobile: String
    let mobileInternationalFormat: String
    let isVerifiedMobile: Bool
    let countryCode, countryRegionCode, typePhone: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case avatar, email, mobile
        case mobileInternationalFormat = "mobile_international_format"
        case isVerifiedMobile = "is_verified_mobile"
        case countryCode = "country_code"
        case countryRegionCode = "country_region_code"
        case typePhone = "type_phone"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName) ?? ""
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        email = try values.decodeIfPresent(String.self, forKey: .email) ?? ""
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile) ?? ""
        mobileInternationalFormat = try values.decodeIfPresent(String.self, forKey: .mobileInternationalFormat) ?? ""
        isVerifiedMobile = try values.decodeIfPresent(Bool.self, forKey: .isVerifiedMobile) ?? false
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode) ?? ""
        countryRegionCode = try values.decodeIfPresent(String.self, forKey: .countryRegionCode) ?? ""
        typePhone = try values.decodeIfPresent(String.self, forKey: .typePhone) ?? ""
        
    }
}

