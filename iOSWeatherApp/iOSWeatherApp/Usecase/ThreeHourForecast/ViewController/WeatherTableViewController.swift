import UIKit
import CoreLocation

class WeatherTableViewController: BaseTableViewController {

    // MARK: - Properties
    
    var weatherFetcher: WeatherFetcher!
    var viewModel: WeatherFetcherViewModel!
    var locationManager: CLLocationManager?

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestAccessToLocation()
    }
    
    // MARK: - Private methods
    
    private func fetchWeatherForecast(lat: String, lon: String) {
        guard Reachability.isConnected() else {
            showErrorMessage(library: MessageLibrary(.network))
            return
        }
        showBusyView()
        weatherFetcher.fetchWeather(latitude: lat, longitude: lon)
    }

    // MARK: - Tableview Delegate methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == .zero ? 1 : viewModel.numberOfRowsInSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == .zero {
            let cell = tableView.dequeueReusableCell(withIdentifier: AreaTableViewCell.identifier, for: indexPath) as! AreaTableViewCell
            cell.configureView(viewModel)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ThreeHourForecastTableViewCell.identifier, for: indexPath) as! ThreeHourForecastTableViewCell
        cell.configureView(viewModel.threeHourForecast[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPath.section == 1 ? navigateToForecastDetail(threeHourForecast: viewModel.threeHourForecast[indexPath.row]) : ()
    }
    
    private func navigateToForecastDetail(threeHourForecast: ThreeHourForecast) {
        let viewController = storyboard?.instantiateViewController(identifier: "ForecastDetailViewController") as! ForecastDetailViewController
        viewController.threeHourForecast = threeHourForecast
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - CLLocationManagerDelegate methods

extension WeatherTableViewController: CLLocationManagerDelegate {
    private func requestAccessToLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
            showErrorMessage(library: MessageLibrary(.location))
            return
        }
        requestLocationPermission()
    }

    private func requestLocationPermission() {
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[locations.count - 1]
        let latitude =  String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        locationManager?.stopUpdatingLocation()
        fetchWeatherForecast(lat: latitude, lon: longitude)
    }
}

// MARK: - WeatherFetcherViewModelDelegate methods

extension WeatherTableViewController: WeatherFetcherViewModelDelegate {
    func didFinishFetching() {
        hideBusyView()
        tableView.reloadData()
    }
}
