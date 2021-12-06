import Foundation
import Alamofire
import AlamofireSwiftyJSON

protocol WeatherServiceGatewayProvider {
    func loadWeatherForCurrentLocation(latitude: String, longitude: String, completion: @escaping (ForecastServiceModel?, Error?) -> Void)
}

class WeatherServiceGateway: WeatherServiceGatewayProvider {
    func loadWeatherForCurrentLocation(latitude: String, longitude: String, completion: @escaping (ForecastServiceModel?, Error?) -> Void) {
        let urlPath = .baseUrl +  "forecast?lat=\(latitude)&lon=\(longitude)&appid=86817880e18fae412c9da8572d9cf191"
        Alamofire.request(urlPath).responseJSON { (response) in
            if response.result.isSuccess {
                guard let result = response.value as? [String: Any]  else {
                    completion(nil, response.error)
                    return
                }
                completion(ForecastServiceModel(jsonDictionary: result), nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
}

private extension String {
    static let baseUrl = "http://api.openweathermap.org/data/2.5/"
}
