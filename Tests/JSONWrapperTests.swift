import Foundation
import XCTest
import AUFleece


class JSONWrapperTests: XCTestCase {
  func testJSONInit() {
    let json: JSONObject = ["foo": "bar"]
    XCTAssertNotNil(JSONWrapper(json: json))
  }
  
  
  func testRawJSONInit() {
    XCTAssertNotNil(try! JSONWrapper(rawJSON: "{\"foo\": \"bar\"}"))
  }
  
  
  func testJSONValue() {
    let subject = try! JSONWrapper(rawJSON: "{\"foo\":\"bar\"}").json
    XCTAssertEqual(subject as! [String:String], ["foo": "bar"])
  }
  
  
  func testFailableInit() {
    XCTAssertNil(try? JSONWrapper(rawJSON: ""))
    XCTAssertNil(try? JSONWrapper(rawJSON: "foobarbaz"))
    XCTAssertNil(try? JSONWrapper(rawJSON: "[\"foo\", \"bar\"]"))
  }
  
  
  func testStringCast() {
    let string = "string"
    let subject = JSONWrapper(json: ["subject": string])
    XCTAssertEqual(string, subject.castValue(for: "subject") as String?)
  }
  
  
  func testIntCast() {
    let int = 42
    let subject = JSONWrapper(json: ["subject": int])
    XCTAssertEqual(int, subject.castValue(for: "subject") as Int?)
  }
  
  
  func testDoubleCast() {
    let double = 3.14
    let subject = JSONWrapper(json: ["subject": double])
    XCTAssertEqual(double, subject.castValue(for: "subject") as Double?)
  }
  
  
  func testBoolCast() {
    let bool = true
    let subject = JSONWrapper(json: ["subject": bool])
    XCTAssertEqual(bool, subject.castValue(for: "subject") as Bool?)
  }
  
  
  func testDefaults() {
    let subject = JSONWrapper(json: [:])
    let def = "bar"
    let optional: String? = subject.castValue(for: "foo")
    let optionalDefault: String? = subject.castValue(for: "foo", or: def)
    let nonOptionalDefault: String = subject.castValue(for: "foo", or: def)
    XCTAssertNil(optional)
    XCTAssertEqual(optionalDefault!, def)
    XCTAssertEqual(nonOptionalDefault, def)
  }
}
