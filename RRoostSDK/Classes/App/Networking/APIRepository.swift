import Foundation

public enum RequestMethod {
  case GET
  case POST
  case PUT
  case DELETE
  case HEAD
  case PATCH
}

public enum ContentType: String {
  case json = "application/json"
}

public typealias RequestCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()
public typealias BodyParameters = [String: String]?
public typealias RequestHeaders = [String: String]?
public typealias QueryParameters = [String: String]?
public typealias Path = String?
public typealias ApiKey = String?
public typealias AccessKey = String?

public struct NetworkRequest {
  var path: Path
  var method: RequestMethod
  var contentType: ContentType?
  var apiKey: ApiKey
  var accessKey: AccessKey

  var body: BodyParameters
  var headers: RequestHeaders?
  var queryParams: QueryParameters

  var data: Data?
  var fileName: String?
}

public protocol NetworkRequestRouter {
  func perform(request: NetworkRequest, completion: @escaping RequestCompletion)
}
