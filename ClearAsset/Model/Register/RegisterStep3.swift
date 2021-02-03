//
//  RegisterStep3.swift
//  ClearAsset
//
//  Created by Peyk Office on 16/01/2021.
//

import Foundation

struct RegisterStep3 : Codable {
    
    var email: String?
    var password: String?
    var rePassword: String?
    var accountType: String?
    var currency: String?
    var fullName: String?
    var birthday: String?
    var country: String?
    var mobile: String?
    var addressOne: String?
    var addressTwo: String?
    var city: String?
    var state: String?
    var zip: String?
    var interested: String?
    var primary: String?

    enum CodingKeys: String, CodingKey {
        case email, password
        case rePassword = "password_confirmation"
        case accountType = "type"
        case currency
        case fullName = "full_name"
        case birthday, country, mobile
        case addressOne = "address_one"
        case addressTwo = "address_two"
        case city, state, zip, interested, primary
    }

    init(email: String?, password: String?, rePassword: String?, accountType: String?, currency: String?, fullName: String?, birthday: String?, country: String?, mobile: String?, addressOne: String?, addressTwo: String?, city: String?, state: String?, zip: String?, interested: String?, primary: String?) {
        self.email = email
        self.password = password
        self.rePassword = rePassword
        self.accountType = accountType
        self.currency = currency
        self.fullName = fullName
        self.birthday = birthday
        self.country = country
        self.mobile = mobile
        self.addressOne = addressOne
        self.addressTwo = addressTwo
        self.city = city
        self.state = state
        self.zip = zip
        self.interested = interested
        self.primary = primary
    }
}

enum Interested: String, Codable {
    case buying = "buying"
    case selling = "seling"
}

enum RegisterStep3LocalError:Int, CustomStringConvertible {
    case phoneNumber = 2000, addressLine1, city, state, zip
    
    var description: String {
        switch self {
        case .phoneNumber:
            return "phoneNumber".getString()
        case .addressLine1:
            return "addressLine1".getString()
        case .city:
            return "city".getString()
        case .state:
            return "state".getString()
        case .zip:
            return "zip".getString()
        }
    }
}

struct DataRegisterStep3Error: Codable {
    let data: RegisterErrorList
}

struct RegisterErrorList: Codable {
    let errors: RegisterError
}

struct RegisterError: Codable {
    let email, mobile: [String]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent([String].self, forKey: .email) ?? [""]
        mobile = try values.decodeIfPresent([String].self, forKey: .mobile) ?? [""]
    }
}
