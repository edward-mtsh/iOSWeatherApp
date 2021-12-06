import XCTest
@testable import iOSWeatherApp

class WeatherFetcherViewModelTests: XCTestCase {
    
    func testGivenForecastServiceModelIsValidThenViewModelShouldShowCorrectly() {
        guard let data = ParsingHelpers.fetchDummyJsonData(jsonFileName: "weather")  else { return }
        do {
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                return
            }
            let mockForecastServiceModel = ForecastServiceModel(jsonDictionary: dictionary)
            verify(mockForecastServiceModel: mockForecastServiceModel, mockError: nil) { viewModel in
                XCTAssertEqual(2, viewModel.numberOfSections)
                XCTAssertNotNil(viewModel.city)
                XCTAssertEqual("London", viewModel.city?.name)
                XCTAssertEqual(1, viewModel.threeHourForecast.count)
            }
        } catch{
        }
    }

    func verify(mockForecastServiceModel: ForecastServiceModel?, mockError: Error?, completion: @escaping (WeatherFetcherViewModel) -> Void) {
        let viewModel = ConcreteWeatherFetcherViewModel(delegate: nil)
        let provider = MockWeatherServiceGatewayProvider(forecast: mockForecastServiceModel, error: mockError)
        let usecase = WeatherFetcher(delegate: viewModel, provider: provider)
        usecase.fetchWeather(latitude: "1234", longitude: "3444")
        completion(viewModel)
    }
}

private class MockWeatherServiceGatewayProvider: WeatherServiceGatewayProvider {
    var forecast: ForecastServiceModel?
    var error: Error?
    
    init(forecast: ForecastServiceModel?, error: Error?) {
        self.forecast = forecast
        self.error = error
    }
    
    func loadWeatherForCurrentLocation(latitude: String, longitude: String, completion: @escaping (ForecastServiceModel?, Error?) -> Void) {
        completion(forecast, error)
    }
}
