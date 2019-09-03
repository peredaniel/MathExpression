//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class SubtractionPerformanceTests: XCTestCase {
    func testPerformanceSimpleSubtraction() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.SubtractionTests.simpleSubtraction, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceSimpleSubtractionWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.SubtractionTests.simpleSubtractionWithParentheses, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceSimpleSubtractionWithParenthesesWithInitialMinus() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.SubtractionTests.simpleSubtractionWithParenthesesWithInitialMinus, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceComplicatedSubtraction() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.SubtractionTests.complicatedSubtraction, a, b, c))
            _ = expression.evaluate()
        }
    }

    func testPerformanceNegativeSingleNumber() {
        let a = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.SubtractionTests.negativeSingleNumber, a))
            _ = expression.evaluate()
        }
    }

    func testPerformanceNegativeExpression() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.SubtractionTests.negativeExpressionWithInitialMinus, a, b, c))
            _ = expression.evaluate()
        }
    }
}
