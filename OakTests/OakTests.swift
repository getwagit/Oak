//
// Copyright (c) 2016-2017 wag it GmbH.
// License: MIT
//

import XCTest
@testable import Oak

class OakTests: XCTestCase {

    let testTree = TestTree()
    let testFile = TestFileX()
    
    override func setUp() {
        super.setUp()
        Oak.plant(testTree)
    }
    
    override func tearDown() {
        Oak.lumber()
        super.tearDown()
    }
    
    func testFileName() {
        let testFile = TestFileX()
        testFile.logMessage("abcde")

        XCTAssert(testTree.lastFileName == "TestFileX", "Wrong filename: \(testTree.lastFileName)")
    }
    
    func testMessage() {
        let testMessage = "This is a test message"
        
        Oak.v(testMessage + "v")
        XCTAssertEqual(testTree.lastMessage, testMessage + "v", "Verbose message did not match")
        Oak.d(testMessage + "d")
        XCTAssertEqual(testTree.lastMessage, testMessage + "d", "Debug message did not match")
        Oak.i(testMessage + "i")
        XCTAssertEqual(testTree.lastMessage, testMessage + "i", "Info message did not match")
        Oak.w(testMessage + "w")
        XCTAssertEqual(testTree.lastMessage, testMessage + "w", "Warn message did not match")
        Oak.e(testMessage + "e")
        XCTAssertEqual(testTree.lastMessage, testMessage + "e", "Error message did not match")
        Oak.wtf(testMessage + "wtf")
        XCTAssertEqual(testTree.lastMessage, testMessage + "wtf", "Assert message did not match")
    }
    
    func testStackTrace() {
        let testFile = TestFileX()
        let testStackAssert = "\n\tOak.TestFileX.logMessageWithStackTrace\n\tOakTests.OakTests.testStackTrace"
        testFile.logMessageWithStackTrace("abcde")
        
        NSLog(testTree.lastStackTree!)
        XCTAssert(testTree.lastStackTree == testStackAssert, "Stack trace does not match: \(testTree.lastStackTree!)")
    }

    func testErrorLogs() {
        Oak.v(TestError.test(uniqueTestInput: "v"))
        XCTAssertEqual(testTree.lastMessage, TestError.localizedTestDescription + "v", "Verbose error message did not match")
        Oak.d(TestError.test(uniqueTestInput: "d"))
        XCTAssertEqual(testTree.lastMessage, TestError.localizedTestDescription + "d", "Debug error message did not match")
        Oak.i(TestError.test(uniqueTestInput: "i"))
        XCTAssertEqual(testTree.lastMessage, TestError.localizedTestDescription + "i", "Info error message did not match")
        Oak.w(TestError.test(uniqueTestInput: "w"))
        XCTAssertEqual(testTree.lastMessage, TestError.localizedTestDescription + "w", "Warn error message did not match")
        Oak.e(TestError.test(uniqueTestInput: "e"))
        XCTAssertEqual(testTree.lastMessage, TestError.localizedTestDescription + "e", "Error error message did not match")
        Oak.wtf(TestError.test(uniqueTestInput: "wtf"))
        XCTAssertEqual(testTree.lastMessage, TestError.localizedTestDescription + "wtf", "Assert error message did not match")
    }
}
