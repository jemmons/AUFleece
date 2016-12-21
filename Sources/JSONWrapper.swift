import Foundation


public struct JSONWrapper {
  public let json: JSONObject
  
  
  public init(json: JSONObject) {
    self.json = json
  }
  
  
  public init(rawJSON: String) throws {
    self.init(json: try rawJSON.toJSON())
  }
  
  
  public func castValue<T>(for key:String, or defaultValue:T? = nil) -> T? {
    return json[key] as? T ?? defaultValue
  }
  
  
  public func castValue<T>(for key:String, or defaultValue:T) -> T {
    return json[key] as? T ?? defaultValue
  }
}
