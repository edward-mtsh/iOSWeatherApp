import Foundation

protocol ImagefetcherGatewayProvider {
    func fetchImage(iconURL: String, completion: @escaping (NSData?) -> Void)
}

class ImagefetcherGateway: ImagefetcherGatewayProvider {
    func fetchImage(iconURL: String, completion: @escaping (NSData?) -> Void) {
        let iconBaseUrl = "http://openweathermap.org/img/w/"
        let iconUrl = "\(iconBaseUrl)\(iconURL).png"
        if let imageUrl = NSURL(string: iconUrl) as URL? {
            completion(NSData(contentsOf:imageUrl))
        }
    }
}
