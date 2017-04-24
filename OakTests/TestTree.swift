//
// Copyright (c) 2016-2017 wag it GmbH.
// License: MIT
//

import Foundation
import Oak

class TestTree: OakTree {
    var lastMessage: String?
    var lastFileName: String?

    func log(_ priority: Int, _ file: String, _ function: String, _ line: Int, _ message: String) {
        lastMessage = message
        lastFileName = fileName(file)
    }
}
