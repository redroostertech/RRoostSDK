import Foundation
import KeychainSwift
import CryptoSwift

let kSaltKey = "nuworld"

class KeychainManager: NSObject {
    
    private let keychain: KeychainSwift!
    
    override init() {
        keychain = KeychainSwift()
    }
    
    // TODO: - Add encryption through CryptoSwift
}

// MARK: - Save data into keychain
extension KeychainManager {
    
    func save(password: String) -> Bool {
        if keychain.set(password, forKey: "password", withAccess: .accessibleWhenUnlocked) {
            return true
        } else {
            return false
        }
    }
    
    func save(text: String, forKey key: String) -> Bool {
        if keychain.set(text, forKey: key, withAccess: .accessibleWhenUnlocked) {
            return true
        } else {
            return false
        }
    }
    
    func save(dict: [String: Any], forKey key: String) -> Bool {
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: dict)
        if keychain.set(data, forKey: key, withAccess: .accessibleWhenUnlocked) {
            return true
        } else {
            return false
        }
    }
    
    func save(preference pref: Bool, forKey key: String) -> Bool {
        if keychain.set(pref, forKey: key, withAccess: .accessibleWhenUnlocked) {
            return true
        } else {
            return false
        }
    }
    
    func save(file: Data, forKey key: String) -> Bool {
        if keychain.set(file, forKey: key, withAccess: .accessibleWhenUnlocked) {
            return true
        } else {
            return false
        }
    }
}

// MARK: - Retrieve data from keychain
extension KeychainManager {
    func retrievePassword() -> String? {
        return keychain.get("password")
    }
    
    func retrieve(dictForKey key: String) -> [String: Any]? {
        if let data = keychain.getData(key) {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? [String : Any]
        } else {
            return nil
        }
    }
    
    func retrieve(text: String) -> String? {
        return keychain.get(text)
    }
    
    func retrieve(preference: String) -> Bool? {
        return keychain.getBool(preference)
    }
    
    func retrieve(file: String) -> Data? {
        return keychain.getData(file)
    }
}

// MARK: - Delete data from keychain
extension KeychainManager {
    func deletePassword() -> Bool {
        return keychain.delete("password")
    }
    
    func delete(dictForKey key: String) -> Bool {
        return keychain.delete(key)
    }
    
    func delete(text: String) -> Bool {
        return keychain.delete(text)
    }
    
    func delete(preference: String) -> Bool {
        return keychain.delete(preference)
    }
    
    func delete(file: String) -> Bool {
        return keychain.delete(file)
    }
}
