//
//  WeatherModel.swift
//  play2Weather
//
//  Created by MD Tanvir Alam on 21/8/20.
//  Copyright © 2020 MD Tanvir Alam. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName:String
    let temp: Double
    let humidity: Double
    var wetBulbTemperature:Double {
        let v1:Double = atan(0.151977 * pow((humidity + 8.313659),(1/2)))
        let v2:Double = atan(temp + humidity) - atan(humidity - 1.676331)
        let v3:Double = 0.00391838 * pow(humidity, 3/2) * atan(0.023101 * humidity)
        return (temp * v1 + v2 + v3 - 4.686035)
    }
    let description: String
}
