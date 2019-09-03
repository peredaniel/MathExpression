//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class DivisionPerformanceTests: XCTestCase {
    func testPerformanceSimpleDivision() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.DivisionTests.simpleDivision, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceSimpleDivisionWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.DivisionTests.simpleDivisionWithParentheses, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceSimpleDivisionWithParenthesesWithInitialDivision() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.DivisionTests.simpleDivisionWithParenthesesWithInitialDivision, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceComplicatedDivision() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.DivisionTests.complicatedDivision, a, b, c))
            _ = expression.evaluate()
        }
    }

    func testPerformanceDivideSingleNumber() {
        let a = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.DivisionTests.divideSingleNumber, a))
            _ = expression.evaluate()
        }
    }

    func testPerformanceConsecutiveDivisionExpressionWithInitialDivision() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.DivisionTests.consecutiveDivisionExpressionWithInitialDivision, a, b, c))
            _ = expression.evaluate()
        }
    }
}
