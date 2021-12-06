import UIKit

class ForecastDetailViewController: BaseViewController {
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var imagefetcher: Imagefetcher!
    var threeHourForecast: ThreeHourForecast!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    private func fetchImage() {
        showBusyView()
        imagefetcher.fetchImage(icon: threeHourForecast.iconURL)
    }
}

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
