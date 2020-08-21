//
//  WeatherManager.swift
//  play2Weather
//
//  Created by MD Tanvir Alam on 20/8/20.
//  Copyright © 2020 MD Tanvir Alam. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager, weatherModel:WeatherModel)
    func didFailWithError(error:Error)
}

struct WeatherManager {
    var url: String = "https://api.openweathermap.org/data/2.5/weather?appid=1402af63b22f776d8ed539b587f3fc31&units=metric"
    var delegate:WeatherManagerDelegate?
    
    func fetchWeatherData(of cityName: String){
        let cityWithoutSpace = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //print(cityWithoutSpace)
        let urlString = url+"&q=\(cityWithoutSpace!)"
        print(urlString)
        self.performRequest(urlString: urlString)
    }
    
    func performRequest(urlString:String){
        // 1. create an URL
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(jsonData: safeData){
                        self.delegate?.didUpdateWeather(self, weatherModel: weather)
                    }
                    //print(safeData)
                }
            }
            task.resume()
        }else{
            print("Whats wrong!!")
        }
    }
    
    func parseJSON(jsonData : Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: jsonData)
            let cityName = decodedData.name
            let description = decodedData.weather[0].description
            let temp = decodedData.main.temp
            let humidity = decodedData.main.humidity
            let weather = WeatherModel(cityName: cityName, temp: temp, humidity: humidity, description: description)
            return weather
        } catch  {
            return nil
        }
    }
}
