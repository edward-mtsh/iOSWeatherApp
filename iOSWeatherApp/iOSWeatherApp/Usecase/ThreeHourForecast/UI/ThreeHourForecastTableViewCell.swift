import UIKit

class ThreeHourForecastTableViewCell: UITableViewCell {
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    func configureView(_ forecast: ThreeHourForecast?) {
        typeLabel.text = forecast?.weatherType
        descriptionLabel.text = forecast?.weatherDescription
        dateLabel.text = forecast?.time
    }
}
