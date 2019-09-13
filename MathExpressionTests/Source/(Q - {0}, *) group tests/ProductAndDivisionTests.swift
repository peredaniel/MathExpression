//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class ProductAndDivisionTests: XCTestCase {
    func testSimpleOperation() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let operation = Operation(
            String(format: Formula.ProductAndDivisionTests.simpleOperation, a, b, c),
            expectedResult: Double(a) / Double(b) * Double(c)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testSimpleOperationWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let operation = Operation(
            String(format: Formula.ProductAndDivisionTests.simpleOperationWithParentheses, a, b, c),
            expectedResult: Double(a) / (Double(c) / Double(b))
        )
        XCTAssertEqual(operation.compute().rounded(toPlaces: 6), operation.expectedResult.rounded(toPlaces: 6))
    }

    func testSimpleOperationWithParenthesesAndInitialDivision() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let operation = Operation(
            String(format: Formula.ProductAndDivisionTests.simpleOperationWithParenthesesAndInitialDivision, a, b, c, d),
            expectedResult: 1.0 / (Double(a) / Double(b)) / Double(c) * Double(d)
        )
        XCTAssertEqual(operation.compute().rounded(toPlaces: 6), operation.expectedResult.rounded(toPlaces: 6))
    }

    func testComplicatedOperationWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let e = Int16.random()
        let f = Int16.random()

        let operation = Operation(
            String(format: Formula.ProductAndDivisionTests.complicatedOperationWithParentheses, a, b, c, d, e, f),
            expectedResult: (1.0 / Double(a) * (Double(b) / Double(c)) * Double(d)) / (Double(e) * Double(f))
        )
        XCTAssertEqual(operation.compute().rounded(toPlaces: 6), operation.expectedResult.rounded(toPlaces: 6))
    }
}
