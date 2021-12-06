import Foundation
import UIKit

protocol ForecastDetailViewModelDelegate: AnyObject {
    func didFinishFeching(image: UIImage)
}

class ConcreteForecastDetailViewModel: ImagefetcherDelegate {
    weak var delegate: ForecastDetailViewModelDelegate?
    
    init(delegate: ForecastDetailViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func didFinishFetchingImage(image: UIImage?) {
        guard let image = image else { return }
        delegate?.didFinishFeching(image: image)
    }
}
