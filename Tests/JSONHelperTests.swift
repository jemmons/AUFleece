import Foundation
import XCTest
@testable import AUFleece

class JSONHelperTests: XCTestCase {
  func testRawObject() {
    let subject = try! "{\"foo\": \"bar\"}".toJSON()
    XCTAssertEqual(subject["foo"] as! String, "bar")
  }
  
  
  func testRawJSONArray() {
    let shouldThrow = expectation(description: "throws notJSONObject error")
    do {
      let _ = try "[1,2,3]".toJSON()
    } catch JSONError.nonObject {
      shouldThrow.fulfill()
    } catch {}
    waitForExpectations(timeout: 0.1, handler: nil)
  }
  
  
  func testInvalidRawJSON() {
    let shouldThrow = expectation(description: "should not parse")
    do {
      let _ = try "foobarbaz".toJSON()
    } catch JSONError.malformed {
      shouldThrow.fulfill()
    } catch {}
    waitForExpectations(timeout: 0.1, handler: nil)
  }
  
  
  func testInvalidByOmission() {
    let shouldThrow = expectation(description: "should not parse")
    do {
      let _ = try "".toJSON()
    } catch JSONError.malformed {
      shouldThrow.fulfill()
    } catch {}
    waitForExpectations(timeout: 0.1, handler: nil)
  }
  
  
  func testEmptyRawJSON() {
    let subject = try! "{}".toJSON()
    XCTAssert(subject.isEmpty)
  }
}
