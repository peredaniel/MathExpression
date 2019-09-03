//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class AdditionAndSubtractionPerformanceTests: XCTestCase {
    func testPerformanceSimpleOperation() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.AdditionAndSubtractionTests.simpleOperation, a, b, c))
            _ = expression.evaluate()
        }
    }

    func testPerformanceSimpleOperationWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.AdditionAndSubtractionTests.simpleOperationWithParentheses, a, b, c))
            _ = expression.evaluate()
        }
    }

    func testPerformanceSimpleOperationWithParenthesesAndInitialMinus() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.AdditionAndSubtractionTests.simpleOperationWithParenthesesAndInitialMinus, a, b, c, d))
            _ = expression.evaluate()
        }
    }
}
