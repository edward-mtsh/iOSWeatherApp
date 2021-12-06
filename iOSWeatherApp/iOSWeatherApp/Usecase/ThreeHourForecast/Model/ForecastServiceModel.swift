class ForecastServiceModel {
    var threeHourForecast : [ThreeHourForecastServiceModel]
    var city: String

    init?(jsonDictionary: [String: Any]) {
        guard let list = jsonDictionary["list"] as? [[String: Any]],
              let city = jsonDictionary["city"] as? [String: Any],
              let cityName = city["name"] as? String else {
            return nil
        }

        var threeHourForecastList = [ThreeHourForecastServiceModel]()

        list.forEach { result in
            if let threeHourForecast = ThreeHourForecastServiceModel(jsonDictionary: result) {
                threeHourForecastList.append(threeHourForecast)
            }
        }

        self.threeHourForecast = threeHourForecastList
        self.city = cityName
    }
}
