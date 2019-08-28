import Foundation

class DefaultsManager {
    private let standard = UserDefaults.standard
    
    init() { }
    
    func setNilDefault(forKey key: String) {
        standard.set(nil, forKey: key)
    }
    func setDefault(withData data: Any, forKey key: String) {
        standard.set(data, forKey: key)
    }
    
    func setDefault(withData data: String, forKey key: String) {
        standard.set(data, forKey: key)
    }
    
    func setDefault(withData data: Int, forKey key: String) {
        standard.set(data, forKey: key)
    }
    
    func setDefault(withData data: Bool, forKey key: String) {
        standard.set(data, forKey: key)
    }
    
    func setDefault(withData data: [String: Any], forKey key: String) {
        standard.setValue(NSKeyedArchiver.archivedData(withRootObject: data), forKey: key)
    }
    
    func setDefault(withData data: Array<Any>, forKey key: String) {
        standard.set(data, forKey: key)
    }

    func retrieveAnyDefault(forKey key: String) -> Any? {
        return standard.object(forKey: key)
    }
    
    func retrieveStringDefault(forKey key: String) -> String? {
        return standard.object(forKey: key) as? String ?? nil
    }
    
    func retrieveIntDefault(forKey key: String) -> Int? {
        return standard.integer(forKey: key)
    }
    
    func retrieveBoolDefault(forKey key: String) -> Bool? {
        return standard.bool(forKey: key)
    }
    
    func retrieveDictDefault(forKey key: String) -> [String:Any]? {
        return standard.dictionary(forKey: key) ?? nil
    }
    
    func retrieveArrayDefault(forKey key: String) -> Array<Any>? {
        return standard.array(forKey: key) ?? nil
    }
    
    func deleteDefault(forKey key: String) {
        standard.removeObject(forKey: key)
    }
    
}
