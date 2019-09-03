//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class SubtractionTests: XCTestCase {
    func testSimpleSubtraction() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.SubtractionTests.simpleSubtraction, a, b),
            expectedResult: Double(a) - Double(b)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testSimpleSubtractionWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.SubtractionTests.simpleSubtractionWithParentheses, a, b),
            expectedResult: Double(a) - Double(b)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testSimpleSubtractionWithParenthesesWithInitialMinus() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.SubtractionTests.simpleSubtractionWithParenthesesWithInitialMinus, a, b),
            expectedResult: Double(b) - Double(a)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testComplicatedSubtraction() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let operation = Operation(
            String(format: Formula.SubtractionTests.complicatedSubtraction, a, b, c),
            expectedResult: Double(a) - Double(b) - Double(c)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testNegativeSingleNumber() {
        let a = Int16.random()
        let operation = Operation(
            String(format: Formula.SubtractionTests.negativeSingleNumber, a),
            expectedResult: Double(a).negative
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testNegativeExpression() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let operation = Operation(
            String(format: Formula.SubtractionTests.negativeExpressionWithInitialMinus, a, b, c),
            expectedResult: Double(a).negative - Double(b) - Double(c)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }
}
