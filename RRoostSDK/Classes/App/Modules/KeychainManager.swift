import Foundation

let kSaltKey = "rrtech-template-app"

public enum KeychainSwiftInterfaceAccessOptions {
  case accessibleAfterFirstUnlock
  case accessibleAfterFirstUnlockThisDeviceOnly
  case accessibleAlways
  case accessibleAlwaysThisDeviceOnly
  case accessibleWhenPasscodeSetThisDeviceOnly
  case accessibleWhenUnlocked
  case accessibleWhenUnlockedThisDeviceOnly
}

public protocol KeychainSwiftInterface: class {
  var synchronizable: Bool { get set }
  var accessGroup: String? { get set }
}
extension KeychainSwiftInterface {
  func set(_ value: Bool, forKey: String, withAccess: KeychainSwiftInterfaceAccessOptions? = nil) -> Bool { return false }
  func set(_ value: String, forKey: String, withAccess: KeychainSwiftInterfaceAccessOptions? = nil) -> Bool { return false }
  func set(_ value: Data, forKey: String, withAccess: KeychainSwiftInterfaceAccessOptions? = nil) -> Bool { return false }
  func get(_ key: String) -> String? { return nil }
  func getBool(_ key: String) -> Bool? { return nil }
  func getData(_ key: String, asReference: Bool? = nil) -> Data? { return nil }
  func clear() { }
  func delete(_ key: String) -> Bool { return false }
}

public class KeychainManager: NSObject {

    private var keychain: KeychainSwiftInterface!

    convenience public init(keychain: KeychainSwiftInterface) {
      self.init()
      self.keychain = keychain
    }
}

// MARK: - Save data into keychain
public extension KeychainManager {
    public func save(password: String) -> Bool? {
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
public extension KeychainManager {
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
public extension KeychainManager {
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
