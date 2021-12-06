import UIKit

class ForecastDetailViewController: BaseViewController {
    
    // MARK: - @IBOutlet declaration
    
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Properties declaration
    
    var imagefetcher: Imagefetcher!
    var threeHourForecast: ThreeHourForecast!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    // MARK: - Provate method
    
    private func fetchImage() {
        showBusyView()
        imagefetcher.fetchImage(icon: threeHourForecast.iconURL)
    }
}

// MARK: - ForecastDetailViewModelDelegate methods

extension ForecastDetailViewController: ForecastDetailViewModelDelegate {
    func didFinishFeching(image: UIImage) {
        hideBusyView()
        title = threeHourForecast.weatherType
        descriptionLabel.text = threeHourForecast.weatherDescription
        iconImage.image = image
        dateLabel.text = threeHourForecast.time
        maxTemperatureLabel.text = "max \(threeHourForecast.maximumTemperature) °C"
        minTemperatureLabel.text = "min \(threeHourForecast.minimumTemperature) °C"
    }
}
