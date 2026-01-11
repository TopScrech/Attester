import XCTest
import AttesterTests

var tests = [XCTestCaseEntry]()
tests += AppAttestTests.allTests()
XCTMain(tests)
