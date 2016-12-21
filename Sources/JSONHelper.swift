import Foundation



internal extension String {
  func toJSON() throws -> JSONObject {
    // This cannot be `nil` when `allowLossyConversion` is `true`. So we force-unwrap.
    // Aside: it should be impossible for any `String` to fail the conversion to UTF-8 (there are currently no characters unrepresentable in UTF-8), but we're being pedantic.
    return try data(using: .utf8, allowLossyConversion: true)!.toJSON()
  }
}



internal extension Data {
  func toJSON() throws -> JSONObject {
    do {
      let object = try JSONSerialization.jsonObject(with: self, options: [])
      guard let json = object as? JSONObject else {
        throw JSONError.nonObject
      }
      return json

    } catch let e as NSError {
      switch (e.domain, e.code) {
      case (NSCocoaErrorDomain, 3840):
        throw JSONError.malformed
      default:
        throw e
      }
    }
  }
}
