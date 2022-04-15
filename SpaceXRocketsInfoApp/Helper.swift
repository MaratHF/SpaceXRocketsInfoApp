//
//  Helper.swift
//  SpaceXRocketsInfoApp
//
//  Created by MAC  on 14.04.2022.
//

import Foundation

class Helper {
    
    static let shared = Helper()
    
    private init() {}
    
    func getDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateStyle = .long
        
        return formatter.string(from: date)
    }
    
    func translateCountry(_ name: String) -> String {
        var country = ""
        if name == "Republic of the Marshall Islands" {
            country = "Маршалловы Острова"
        } else {
            country = "США"
        }
        return country
    }
}
