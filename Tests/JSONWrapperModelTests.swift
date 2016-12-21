import Foundation
import XCTest
import AUFleece


class JSONWrapperModelTests: XCTestCase {
  private class MyModel: JSONWrapperModel {
    var name: String? {
      return castValue(for: "name")
    }
    
    var carryingWheel: Bool {
      return castValue(for: "carrying_wheel", or: false)
    }
  }
  
  
  func testRealJSON() {
    let json: JSONObject = ["name": "Jonas", "carrying_wheel": true]
    let subject = MyModel(json: json)
    XCTAssertEqual(subject.name!, "Jonas")
    XCTAssert(subject.carryingWheel)
    XCTAssert((subject.json as NSDictionary).isEqual(to: json))
  }
  
  
  func testDefaults() {
    let subject = MyModel(json: [:])
    XCTAssertNil(subject.name)
    XCTAssertFalse(subject.carryingWheel)
  }
}
