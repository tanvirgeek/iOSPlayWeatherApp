//
//  ViewController.swift
//  play2Weather
//
//  Created by MD Tanvir Alam on 20/8/20.
//  Copyright © 2020 MD Tanvir Alam. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,WeatherManagerDelegate {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var wetTemp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var cityNameTextField: UITextField!
    var weatherManager = WeatherManager()
    @IBOutlet weak var weatherName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameTextField.delegate = self
        weatherManager.delegate = self
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == ""{
            textField.placeholder = "Type City Name :)"
            return false
        }
        else{
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text ?? "No city name")
        if let cityName = textField.text {
           weatherManager.fetchWeatherData(of: cityName)
        }
        
        textField.text = ""
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel) {
        
        DispatchQueue.main.async {
            self.cityName.text = weatherModel.cityName
            self.temp.text = String(weatherModel.temp)
            self.weatherName.text = weatherModel.description
            self.humidity.text = String(weatherModel.humidity)
            self.wetTemp.text = String(weatherModel.wetBulbTemperature)
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

