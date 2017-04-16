//
// Copyright (c) 2017 wag it GmbH.
// License: MIT
//

import Foundation

enum TestError: Error {
    case test(uniqueTestInput: String)
}

extension TestError: LocalizedError {
    public static var localizedTestDescription: String {
        return "localizedTestDescription"
    }

    public var errorDescription: String? {
        switch self {
        case .test(let uniqueTestInput):
            return TestError.localizedTestDescription + uniqueTestInput
        }
    }
}