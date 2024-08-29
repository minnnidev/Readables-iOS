//
//  HomeViewModel.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit

final class HomeViewModel {

    private(set) var isKeywordOpened = Observable(false)
    private(set) var keywordOb = Observable<[Keyword]>([])
    private(set) var thisWeekRecommendOb = Observable<BooksWithHeader>(.init(headerTitle: "", books: []))
    private(set) var popularLoansOb = Observable<BooksWithHeader>(.init(headerTitle: "", books: []))
    private(set) var ageTrendOb = Observable<BooksWithHeader>(.init(headerTitle: "", books: []))
    private(set) var loadState = Observable(LoadState.initial)
    private(set) var currentBackgroundImage = Observable<String>(WeatherImage.images.first ?? "clear")
    private var imageTimer: Timer?
    private var currentImageIndex = 0

    enum Action {
        case setKeywordExpandState(newState: Bool)
        case loadBooks
        case loadBackgroundImageView
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

        case .loadBackgroundImageView:
            setImageTimer()
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

    private func setImageTimer() {
        imageTimer?.invalidate()
        imageTimer = Timer.scheduledTimer(
            timeInterval: 5,
            target: self,
            selector: #selector(changeBackgroundImage),
            userInfo: nil,
            repeats: true
        )
    }

    @objc private func changeBackgroundImage() {
        currentImageIndex = (currentImageIndex + 1) % WeatherImage.images.count
        currentBackgroundImage.value = WeatherImage.images[currentImageIndex]
    }
}
