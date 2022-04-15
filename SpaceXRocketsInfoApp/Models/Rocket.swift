//
//  Models.swift
//  SpaceXRocketsInfoApp
//
//  Created by MAC  on 11.04.2022.
//

import Foundation

struct Rocket: Decodable {
    let name: String
    let id: String
    let firstFlight: Date
    let country: String
    let costPerLaunch: Int
    let firstStage: Stage
    let secondStage: Stage
    let flickrImages: [String]
}

struct Stage: Decodable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSec: Int?
}

struct Launch: Decodable {
    let name: String
    let rocket: String
    let dateUtc: Date
    let success: Bool?
}
