//
//  WeatherService.swift
//  BookTalk
//
//  Created by RAFA on 9/7/24.
//

import CoreLocation
import WeatherKit

final class WeatherServiceManager {

    func fetchWeather(for location: CLLocation) async -> WeatherCondition? {
        let weatherService = WeatherService()

        do {
            let weather = try await weatherService.weather(for: location)
            return weather.currentWeather.condition
        } catch {
            print("DEBUG: Weather fetching error \(error)")
            return nil
        }
    }
}
