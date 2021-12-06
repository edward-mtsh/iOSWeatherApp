import Foundation
import UIKit

protocol ImagefetcherDelegate {
    func didFinishFetchingImage(image: UIImage?)
}

class Imagefetcher {
    private let delegate: ImagefetcherDelegate
    private let provider: ImagefetcherGatewayProvider
    
    init(delegate: ImagefetcherDelegate, provider: ImagefetcherGatewayProvider) {
        self.delegate = delegate
        self.provider = provider
    }
    
    func fetchImage(icon: String) {
        provider.fetchImage(iconURL: icon) { nsData in
            guard let data = nsData else {
                self.delegate.didFinishFetchingImage(image: nil)
                return
            }
            let image = UIImage(data:Data(referencing: data) as Data)
            self.delegate.didFinishFetchingImage(image: image)
        }
    }
}
