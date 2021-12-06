import XCTest

class ParsingHelpers {
    static func fetchDummyJsonData(jsonFileName: String, valueOverrides: [String: String]? = nil) -> Data? {
        if let path = Bundle(for: ParsingHelpers.self).path(forResource: jsonFileName, ofType: "json") {
            do {
                guard let valueOverrides = valueOverrides else {
                    return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                }
                
                var fileContent = try String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)
                for (_, pair) in valueOverrides.enumerated() {
                    fileContent = fileContent.replacingOccurrences(of: pair.key, with: pair.value)
                }
                
                return fileContent.data(using: .utf8)
            } catch let error {
                XCTFail(error.localizedDescription)
            }
        } else {
            XCTFail("Could not find data file: \(jsonFileName)")
        }
        return nil
    }
}
