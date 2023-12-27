//
//  Deal.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/26/23.
//

import Foundation

struct Deal: Codable {
    let id: Int
    let status: String
    let buyer: User
    
}

struct AddressList: Codable {
    let list: [Address]
}

struct Address: Codable {
    let id: Int
    let primaryAddress: Bool
    let streetAddress: String
    let suite: String?
    let city: String
    let state: String
    let zipcode: String
    let housingstatus: String
    let durationYears: Int?
    let durationMonths: Int?
    let monthlyPayment: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case primaryAddress = "primary_address"
        case streetAddress = "street_address"
        case suite
        case city
        case state
        case zipcode
        case housingstatus = "housing_status"
        case durationYears = "duration_years"
        case durationMonths = "duration_months"
        case monthlyPayment = "monthly_payment"
    }
}

struct Employment: Codable {
    let id: String
    let name: String
    let jobTitle: String
    let address: String?
    let suite: String?
    let city: String?
    let state: String?
    let zipcode: String?
    let grossIncome: String?
    let salaryType: String?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case jobTitle = "job_title"
        case address
        case suite
        case city
        case state
        case zipcode
        case grossIncome = "gross_income"
        case salaryType = "salary_type"
        case status
    }
}

struct TradeVehicle: Codable {
    let id: Int
    let maker: String
    let model: String
    let year: String
}

struct VehicleForPurchase: Codable {
    let id: String
    let vin: String?
    let stockNumber: String
    let model: String?
    let maker: String?
    let condition: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case vin
        case stockNumber = "stock_number"
        case model
        case maker
        case condition
    }
}

struct DriverLicense: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let licenseState: String
    let streetAddress: String
    let suite: String?
    let city: String
    let state: String
    let zipCode: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case licenseState = "license_state"
        case streetAddress = "street_address"
        case suite
        case city
        case state
        case zipCode = "xip_code"
    }
}

extension Address {
    
    func showCompleteAddress() -> String {
        if let suite {
            return "\(streetAddress),\(suite) ,\(city), \(state), \(zipcode)"
        } else {
            return "\(streetAddress), \(city), \(state), \(zipcode)"
        }
    }
    
    func showTimeAtAddress () -> String {
        if let durationYears {
            if let durationMonths {
                return "\(durationYears) Yrs \(durationMonths) Mos"
            } else {
                return "\(durationYears) Yrs"
            }
        } else {
           return  "-"
        }
    }
    
    func showMonthlyPaymentWIthCurrency() -> String {
        return "$ \(monthlyPayment)"
    }
}
