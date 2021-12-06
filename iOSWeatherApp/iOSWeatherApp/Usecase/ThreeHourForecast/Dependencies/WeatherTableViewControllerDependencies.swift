import CoreLocation

extension WeatherTableViewController{
    override func injectDependencies() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        let provider = WeatherServiceGateway()
        viewModel = ConcreteWeatherFetcherViewModel(delegate: self)
        weatherFetcher = WeatherFetcher(delegate: viewModel as! WeatherFetcherDelegate, provider: provider)
    }
}
