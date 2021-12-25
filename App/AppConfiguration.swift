import Foundation
import GoogleSignIn

class AppConfiguration {
    static let shared = AppConfiguration()
    let signInConfiguration = GIDConfiguration.init(clientID: "480680141888-ai7b97ff84r3inio2ue1i33qbvi8bsfj.apps.googleusercontent.com")
}
