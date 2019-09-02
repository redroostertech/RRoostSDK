import Foundation

public extension Decodable {
  /// Initialies the Decodable object with a JSON dictionary.
  ///
  /// - Parameter jsonDictionary: json dictionary.
  /// - Throws: throws an error if the initialization fails.
  init(jsonDictionary: [String: Any]) throws {
    let decoder = JSONDecoder()
    let data = try JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
    self = try decoder.decode(Self.self, from: data)
  }

}

public extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
