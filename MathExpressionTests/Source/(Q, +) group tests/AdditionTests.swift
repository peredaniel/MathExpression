//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class AdditionTests: XCTestCase {
    func testSimpleAddition() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.AdditionTests.simpleAddition, a, b),
            expectedResult: Double(a) + Double(b)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testComplicatedAddition() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let operation = Operation(
            String(format: Formula.AdditionTests.complicatedAddition, a, b, c, d),
            expectedResult: Double(a) + Double(b) + Double(c) + Double(d)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testSimpleAdditionWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.AdditionTests.simpleAdditionWithParentheses, a, b),
            expectedResult: Double(a) + Double(b)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testComplicatedAdditionWithSingleParenthesis() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let operation = Operation(
            String(format: Formula.AdditionTests.complicatedAdditionWithSingleParenthesis, a, b, c, d),
            expectedResult: Double(a) + Double(b) + Double(c) + Double(d)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testComplicatedAdditionWithMultipleParenthesis() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let e = Int16.random()
        let f = Int16.random()
        let operation = Operation(
            String(format: Formula.AdditionTests.complicatedAdditionWithMultipleParenthesis, a, b, c, d, e, f),
            expectedResult: Double(a) + Double(b) + Double(c) + Double(d) + Double(e) + Double(f)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }
}
