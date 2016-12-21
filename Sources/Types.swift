public typealias JSONObject = [AnyHashable: Any]

internal enum JSONError: Error {
  case nonObject, malformed
}

