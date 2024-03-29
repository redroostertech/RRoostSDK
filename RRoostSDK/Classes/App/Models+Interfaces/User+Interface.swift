import Foundation

public protocol BaseUser: class {
  var id: String { get set }
  var email: String { get set }
  var name: String { get set }
  var type: String { get set }
  var image: String? { get set }
}
