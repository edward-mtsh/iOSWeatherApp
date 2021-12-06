import Foundation

protocol WeatherFetcherViewModelDelegate: AnyObject {
    func didFinishFetching()
}

protocol WeatherFetcherViewModel {
    var threeHourForecast: [ThreeHourForecast] {get set}
    var city: City? { get set}
    var numberOfRowsInSection: Int { get set}
    var numberOfSections: Int { get set}
}

class ConcreteWeatherFetcherViewModel: WeatherFetcherViewModel, WeatherFetcherDelegate {
    var threeHourForecast: [ThreeHourForecast] = [ThreeHourForecast]()
    var city: City?
    var numberOfRowsInSection: Int = 0
    var numberOfSections: Int = 0
    
    private weak var delegate: WeatherFetcherViewModelDelegate?
    
    init(delegate: WeatherFetcherViewModelDelegate) {
        self.delegate = delegate
    }
    
    func didFinishFetchingWeather(forecast: Forecast?, error: Error?) {
        guard error == nil, let threeHourForecast = forecast?.threeHourForecast, let city = forecast?.city else {
            return
        }
        self.threeHourForecast = threeHourForecast
        self.city = city
        self.numberOfRowsInSection = threeHourForecast.count
        self.numberOfSections = 2
        self.delegate?.didFinishFetching()
    }
}
