import UIKit
import Foundation

class MessageLibrary {
    
    var title:String = ""
    var message:String = ""
    
    init(_ type: ErrorHandling) {
        switch type {
        case .network:
            title = "No Internet Connection"
            message = "Make sure your device is connected to the internet."
            break
        case .serverFailure:
            title = "Error"
            message = "Oops! Something went wrong. Please try again."
            break
        case .location:
            title = "Access to Location"
            message = "Your location needs to be turned on before you can use weather forecast"
            break
        }
    }
}
