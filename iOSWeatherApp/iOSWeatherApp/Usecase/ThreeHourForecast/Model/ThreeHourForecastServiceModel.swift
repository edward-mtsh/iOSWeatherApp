class ThreeHourForecastServiceModel {
    var minimumTemperature: Double
    var maximumTemperature: Double
    var iconURL: String
    var time: String
    var weatherType: String
    var weatherDescription: String
    
    init?(jsonDictionary: [String: Any]) {
        guard let main = jsonDictionary["main"] as? [String: Any],
              let weatherDictionary = jsonDictionary["weather"] as? [[String: Any]],
              let weather = weatherDictionary.first,
              let iconURL = weather["icon"] as? String,
              let weatherDescription = weather["description"] as? String,
              let weatherType = weather["main"] as? String,
              let maximumTemperature = main["temp_max"] as? Double,
              let minimumTemperature = main["temp_min"] as? Double,
              let time = jsonDictionary["dt_txt"] as? String else {
            return(nil)
        }

        self.minimumTemperature = minimumTemperature
        self.maximumTemperature = maximumTemperature
        self.iconURL = iconURL
        self.weatherDescription = weatherDescription
        self.weatherType = weatherType
        self.time = time
    }
}
