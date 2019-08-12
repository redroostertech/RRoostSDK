import Foundation
import UIKit

public extension UserDefaults {
    enum Main {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }
    
    struct Authentication {
        static let sessionActive = "sessionActive"
        static let loggedInFailedAttempts = "loggedInFailedAttempts"
    }

    struct User {
        static let userid = "userID"
        static let username = "userName"
    }
//    
    func storeLocalProperties(data: [String: Any],
                              completion: @escaping () -> Void)
    {
        for key in data.keys {
            let item = data[key]
            self.set(item, forKey: key)
        }
        completion()
    }
  
    func destroyLocalDefaultProperties(completion: @escaping () -> Void) {
        self.synchronize()
    }
}

public extension UserDefaults {
    enum DefaultProfileSettings {
//        static let accessToken = {
//            return UserDefaults.standard.value(forKey: self.ProfileKeys.accessToken) ?? nil
//        }()
//        static let refreshRoken = {
//            return UserDefaults.standard.value(forKey: self.ProfileKeys.refreshRoken) ?? nil
//        }()
//        static let sportsID = {
//            return UserDefaults.standard.value(forKey: self.ProfileKeys.sportsID) ?? nil
//        }()
//        static let profileGUID = {
//            return UserDefaults.standard.value(forKey: self.ProfileKeys.profileGuid) ?? nil
//        }()
    }
    
}
