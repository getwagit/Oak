//
//  Created by Markus Riegel on 22.08.16.
//  Copyright © 2016 wag it GmbH. All rights reserved.
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
        XCTAssert(testTree.lastMessage == testMessage + "v", "Verbose message did not match")
        Oak.d(testMessage + "d")
        XCTAssert(testTree.lastMessage == testMessage + "d", "Debug message did not match")
        Oak.i(testMessage + "i")
        XCTAssert(testTree.lastMessage == testMessage + "i", "Info message did not match")
        Oak.w(testMessage + "w")
        XCTAssert(testTree.lastMessage == testMessage + "w", "Warn message did not match")
        Oak.e(testMessage + "e")
        XCTAssert(testTree.lastMessage == testMessage + "e", "Error message did not match")
        Oak.wtf(testMessage + "wtf")
        XCTAssert(testTree.lastMessage == testMessage + "wtf", "Assert message did not match")
    }
    
    func testStackTrace() {
        let testFile = TestFileX()
        let testStackAssert = "\n\tOak.TestFileX.logMessageWithStackTrace\n\tOakTests.OakTests.testStackTrace"
        testFile.logMessageWithStackTrace("abcde")
        
        NSLog(testTree.lastStackTree!)
        XCTAssert(testTree.lastStackTree == testStackAssert, "Stack trace does not match: \(testTree.lastStackTree!)")
    }
}
