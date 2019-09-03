//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class AdditionAndSubtractionTests: XCTestCase {
    func testSimpleOperation() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let operation = Operation(
            String(format: Formula.AdditionAndSubtractionTests.simpleOperation, a, b, c),
            expectedResult: Double(a) - Double(b) + Double(c)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testSimpleOperationWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let operation = Operation(
            String(format: Formula.AdditionAndSubtractionTests.simpleOperationWithParentheses, a, b, c),
            expectedResult: Double(a) + Double(b) - Double(c)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testSimpleOperationWithParenthesesAndInitialMinus() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let operation = Operation(
            String(format: Formula.AdditionAndSubtractionTests.simpleOperationWithParenthesesAndInitialMinus, a, b, c, d),
            expectedResult: Double(a).negative + Double(b) - Double(c) + Double(d)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }
}
