//
// Created by Markus Riegel on 21.09.16.
// Copyright (c) 2016 wag it GmbH. All rights reserved.
//

import Foundation

class TestFileX {
    init() {}

    func logMessage(_ msg: String) {
        Oak.d(msg)
    }
    
    func logMessageWithStackTrace(_ msg: String) {
        Oak.d(msg, Thread.callStackSymbols)
    }
}
