//
//  HomeViewModel.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import CoreLocation
import UIKit
import WeatherKit

final class HomeViewModel {

    private(set) var isKeywordOpened = Observable(false)
    private(set) var keywordOb = Observable<[Keyword]>([])
    private(set) var thisWeekRecommendOb = Observable<BooksWithHeader>(.init(headerTitle: "", books: []))
    private(set) var popularLoansOb = Observable<BooksWithHeader>(.init(headerTitle: "", books: []))
    private(set) var ageTrendOb = Observable<BooksWithHeader>(.init(headerTitle: "", books: []))
    private(set) var loadState = Observable(LoadState.initial)
    private(set) var weatherConditionOb = Observable<WeatherCondition?>(nil)

    private let locationManager = LocationManager()
    private let weatherService = WeatherServiceManager()

    init() {
        locationManager.delegate = self
    }

    enum Action {
        case setKeywordExpandState(newState: Bool)
        case loadBooks
        case fetchLocationAndWeather
    }

    func send(action: Action) {
        switch action {
        case let .setKeywordExpandState(newState):
            isKeywordOpened.value = newState

        case .loadBooks:
            Task {
                await loadKeyword()
                await loadHotTrend()
                await loadThisWeekTrend()
                await loadAgeTrend()
            }

        case .fetchLocationAndWeather:
            locationManager.requestLocation()
        }
    }

    func backgroundImage(for condition: WeatherCondition?) -> UIImage? {
        guard let condition = condition else { return UIImage(named: "sunny") }

        switch condition {
        case .blizzard:
            return UIImage(named: "snow")
        case .blowingDust:
            return UIImage(named: "dust")
        case .blowingSnow:
            return UIImage(named: "snow")
        case .breezy:
            return UIImage(named: "windy")
        case .clear:
            return UIImage(named: "sunny")
        case .cloudy:
            return UIImage(named: "cloudy")
        case .drizzle:
            return UIImage(named: "rain")
        case .flurries:
            return UIImage(named: "snow")
        case .foggy:
            return UIImage(named: "foggy")
        case .freezingDrizzle:
            return UIImage(named: "snow")
        case .freezingRain:
            return UIImage(named: "hail")
        case .frigid:
            return UIImage(named: "snow")
        case .hail:
            return UIImage(named: "hail")
        case .haze:
            return UIImage(named: "foggy")
        case .heavyRain:
            return UIImage(named: "rain")
        case .heavySnow:
            return UIImage(named: "snow")
        case .hot:
            return UIImage(named: "sunny")
        case .hurricane:
            return UIImage(named: "tornado")
        case .isolatedThunderstorms:
            return UIImage(named: "thunder")
        case .mostlyClear:
            return UIImage(named: "sunny")
        case .mostlyCloudy:
            return UIImage(named: "cloudy")
        case .partlyCloudy:
            return UIImage(named: "cloudy")
        case .rain:
            return UIImage(named: "rain")
        case .scatteredThunderstorms:
            return UIImage(named: "thunder")
        case .sleet:
            return UIImage(named: "snow")
        case .smoky:
            return UIImage(named: "foggy")
        case .snow:
            return UIImage(named: "snow")
        case .strongStorms:
            return UIImage(named: "thunder")
        case .sunFlurries:
            return UIImage(named: "sunFlurries")
        case .sunShowers:
            return UIImage(named: "sunShowers")
        case .thunderstorms:
            return UIImage(named: "thunder")
        case .tropicalStorm:
            return UIImage(named: "thunder")
        case .windy:
            return UIImage(named: "windy")
        case .wintryMix:
            return UIImage(named: "snow")
        default:
            return UIImage(named: "sunny")
        }
    }

    private func loadKeyword() async {
        do {
            let result = try await BookService.getKeywords()

            await MainActor.run {
                keywordOb.value = result
            }

        } catch {
            print(error.localizedDescription)
        }
    }

    private func loadHotTrend() async {
        do {
            let result = try await HomeService.getHotTrend()

            await MainActor.run {
                popularLoansOb.value.books = result
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    private func loadThisWeekTrend() async {
        do {
            let result = try await HomeService.getThisWeekTrend()

            await MainActor.run {
                thisWeekRecommendOb.value.books = result
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    private func loadAgeTrend() async {
        let age = UserData.shared.getUser()?.birth?.toKoreanAge() ?? ""

        do {
            let result = try await HomeService.getAgeTrend(of: age)

            await MainActor.run {
                ageTrendOb.value.books = result
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - LocationManagerDelegate

extension HomeViewModel: LocationManagerDelegate {

    func didUpdateLocation(_ location: CLLocation) {
        Task {
            if let condition = await weatherService.fetchWeather(for: location) {
                weatherConditionOb.value = condition
            }
        }
    }
}
