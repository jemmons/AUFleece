import Foundation



open class JSONWrapperModel {
  private let jsonWrapper: JSONWrapper
  
  
  public var json: JSONObject {
    return jsonWrapper.json
  }
  
  
  public init(json: JSONObject) {
    jsonWrapper = JSONWrapper(json: json)
  }
  
  
  public init(rawJSON: String) throws {
    jsonWrapper = try JSONWrapper(rawJSON: rawJSON)
  }
  
  
  /// In practice, we will rarely want to provide a default value when casting to an optional type. So why make it an explicit (if defaulted) param?
  /// Swift will not cast `AnyObject` to a more optional type. If we didn't have a `(String, T?)->T?` version, code like `let foo: String? = castValueForKey("bar", or: "baz")` would *always* return `"baz"`.
  /// This is unexpected and dangerous enough to warant the slight increase in autocomplete verbosity.
  public func castValue<T>(for key: String, or defaultValue: T? = nil) -> T? {
    return jsonWrapper.castValue(for: key, or: defaultValue)
  }


  public func castValue<T>(for key: String, or defaultValue: T) -> T {
    return jsonWrapper.castValue(for: key, or: defaultValue)
  }
}
