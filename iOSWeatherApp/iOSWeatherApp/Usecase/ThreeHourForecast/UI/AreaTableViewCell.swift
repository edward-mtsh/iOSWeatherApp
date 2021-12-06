import UIKit

class AreaTableViewCell: UITableViewCell {
    @IBOutlet private weak var areaLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    func configureView(_ viewModel: WeatherFetcherViewModel) {
        areaLabel.text = viewModel.city?.name
        dateLabel.text = viewModel.city?.date
    }
}
