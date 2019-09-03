//  Copyright © 2019 Pedro Daniel Prieto Martínez. All rights reserved.

import XCTest

class ProductTests: XCTestCase {
    func testSimpleProduct() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.ProductTests.simpleProduct, a, b),
            expectedResult: Double(a) * Double(b)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testComplicatedProduct() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let operation = Operation(
            String(format: Formula.ProductTests.complicatedProduct, a, b, c, d),
            expectedResult: Double(a) * Double(b) * Double(c) * Double(d)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testSimpleProductWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.ProductTests.simpleProductWithParentheses, a, b),
            expectedResult: Double(a) * Double(b)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testComplicatedAdditionWithSingleParenthesis() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let operation = Operation(
            String(format: Formula.ProductTests.complicatedProductWithSingleParenthesis, a, b, c, d),
            expectedResult: Double(a) * Double(b) * Double(c) * Double(d)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testComplicatedProductWithMultipleParenthesis() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let operation = Operation(
            String(format: Formula.ProductTests.complicatedProductWithMultipleParenthesis, a, b, c, d),
            expectedResult: Double(a) * Double(b) * Double(c) * Double(d)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }
}
