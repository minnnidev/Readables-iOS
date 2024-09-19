//
//  UIImage+WeatherCondition.swift
//  BookTalk
//
//  Created by RAFA on 9/8/24.
//

import UIKit
import WeatherKit

extension UIImage {

    static func image(for condition: WeatherCondition?) -> UIImage? {
        guard let condition = condition else { return UIImage(named: "sunny") }

        switch condition {
        case .blizzard, .blowingSnow, .frigid, .flurries, .heavySnow, .snow, .wintryMix:
            return UIImage(named: "snow")
        case .blowingDust:
            return UIImage(named: "dust")
        case .breezy, .windy:
            return UIImage(named: "windy")
        case .clear, .mostlyClear, .hot:
            return UIImage(named: "sunny")
        case .cloudy, .mostlyCloudy, .partlyCloudy:
            return UIImage(named: "cloudy")
        case .drizzle, .rain, .freezingRain, .heavyRain, .freezingDrizzle:
            return UIImage(named: "rain")
        case .sunShowers:
            return UIImage(named: "sunShowers")
        case .foggy, .haze, .smoky:
            return UIImage(named: "foggy")
        case .hail:
            return UIImage(named: "hail")
        case .hurricane, .tropicalStorm:
            return UIImage(named: "tornado")
        case .isolatedThunderstorms, .thunderstorms, .strongStorms, .scatteredThunderstorms:
            return UIImage(named: "thunder")
        case .sunFlurries:
            return UIImage(named: "sunFlurries")
        default:
            return UIImage(named: "sunny")
        }
    }
}
