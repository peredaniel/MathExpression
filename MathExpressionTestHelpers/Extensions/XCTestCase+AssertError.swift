//  Copyright © 2022 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import XCTest

extension XCTestCase {
    func assert<T, E: Error & Equatable>(
        _ expression: @autoclosure () throws -> T,
        throws error: E,
        in file: StaticString = #file,
        line: UInt = #line
    ) {
        var thrownError: Error?

        XCTAssertThrowsError(try expression(), file: file, line: line) { error in
            thrownError = error
        }

        XCTAssertTrue(thrownError is E, "Unexpected error type: \(type(of: thrownError))", file: file, line: line)
        XCTAssertEqual(thrownError as? E, error, file: file, line: line)
    }
}
