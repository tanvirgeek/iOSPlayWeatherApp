//
//  WeatherData.swift
//  play2Weather
//
//  Created by MD Tanvir Alam on 20/8/20.
//  Copyright © 2020 MD Tanvir Alam. All rights reserved.
//

import Foundation

struct WeatherData:Decodable {
    let name: String
    let weather: [Weather]
    let main : Main
}

struct Main:Decodable{
    let temp: Double
    let humidity: Double
}

struct Weather:Decodable {
    let description: String
}
