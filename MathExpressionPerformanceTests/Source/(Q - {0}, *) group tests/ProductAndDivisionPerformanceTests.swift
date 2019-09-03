//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class ProductAndDivisionPerformanceTests: XCTestCase {
    func testPerformanceSimpleOperation() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.ProductAndDivisionTests.simpleOperation, a, b, c))
            _ = expression.evaluate()
        }
    }

    func testPerformanceSimpleOperationWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.ProductAndDivisionTests.simpleOperationWithParentheses, a, b, c))
            _ = expression.evaluate()
        }
    }

    func testPerformanceSimpleOperationWithParenthesesAndInitialDivision() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.ProductAndDivisionTests.simpleOperationWithParenthesesAndInitialDivision, a, b, c, d))
            _ = expression.evaluate()
        }
    }

    func testPerformanceComplicatedOperationWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let e = Int16.random()
        let f = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.ProductAndDivisionTests.complicatedOperationWithParentheses, a, b, c, d, e, f))
            _ = expression.evaluate()
        }
    }
}
