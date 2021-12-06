import Foundation

struct Forecast {
    let threeHourForecast : [ThreeHourForecast]
    let city: City
}

struct ThreeHourForecast {
    let minimumTemperature: Double
    let maximumTemperature: Double
    let iconURL: String
    let time: String
    let weatherType: String
    let weatherDescription: String
}

struct City {
    let name: String
    let date: String
}

protocol WeatherFetcherDelegate {
    func didFinishFetchingWeather(forecast: Forecast?, error: Error?)
}

class WeatherFetcher {

    // MARK: - Prpperties
    
    private let delegate: WeatherFetcherDelegate!
    private let provider: WeatherServiceGatewayProvider!
    
    // MARK: - Init
    
    init(delegate: WeatherFetcherDelegate, provider: WeatherServiceGatewayProvider) {
        self.delegate = delegate
        self.provider = provider
    }
    
    // MARK: - Public methods
    
    func fetchWeather(latitude: String, longitude: String) {
        provider.loadWeatherForCurrentLocation(latitude: latitude, longitude: longitude) { weather, error in
            self.delegate.didFinishFetchingWeather(forecast: self.forecast(weather), error: error)
        }
    }
    
    // MARK: - Private methods
    
    private func forecast(_ forecastServiceModel: ForecastServiceModel?) -> Forecast {
        var threeHourForecast = [ThreeHourForecast]()
        forecastServiceModel?.threeHourForecast.forEach({ forecast in
            threeHourForecast.append(
                ThreeHourForecast(
                    minimumTemperature: forecast.minimumTemperature,
                    maximumTemperature: forecast.maximumTemperature,
                    iconURL: forecast.iconURL,
                    time: forecast.time,
                    weatherType: forecast.weatherType,
                    weatherDescription: forecast.weatherDescription)
            )
        })
        return Forecast(threeHourForecast: threeHourForecast, city: City(name: forecastServiceModel?.city ?? "", date: getDate()))
    }
    
    private func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let formatedDate = formatter.string(from: date)
        return "Today, \(formatedDate)"
    }
}
