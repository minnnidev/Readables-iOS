//
//  WeatherService.swift
//  BookTalk
//
//  Created by RAFA on 9/7/24.
//

import CoreLocation
import WeatherKit

protocol WeatherServiceManagerDelegate: AnyObject {
    
    func didUpdateWeatherCondition(_ condition: WeatherCondition?)
}

final class WeatherServiceManager {

    weak var delegate: WeatherServiceManagerDelegate?

    func fetchWeather(for location: CLLocation) async {
        let weatherService = WeatherService()

        do {
            let weather = try await weatherService.weather(for: location)
            delegate?.didUpdateWeatherCondition(weather.currentWeather.condition)
        } catch {
            print("DEBUG: Weather fetching error \(error)")
        }
    }
}
