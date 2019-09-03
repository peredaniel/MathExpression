//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class ProductPerformanceTests: XCTestCase {
    func testPerformanceSimpleProduct() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.ProductTests.simpleProduct, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceComplicatedProduct() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.ProductTests.complicatedProduct, a, b, c, d))
            _ = expression.evaluate()
        }
    }

    func testPerformanceSimpleProductWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.ProductTests.simpleProductWithParentheses, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceComplicatedAdditionWithSingleParenthesis() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.ProductTests.complicatedProductWithSingleParenthesis, a, b, c, d))
            _ = expression.evaluate()
        }
    }

    func testPerformanceComplicatedProductWithMultipleParenthesis() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.ProductTests.complicatedProductWithMultipleParenthesis, a, b, c, d))
            _ = expression.evaluate()
        }
    }
}
