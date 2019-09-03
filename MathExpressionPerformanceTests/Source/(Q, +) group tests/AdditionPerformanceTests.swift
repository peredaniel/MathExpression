//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class AdditionPerformanceTests: XCTestCase {
    func testPerformanceSimpleAddition() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.AdditionTests.simpleAddition, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceComplicatedAddition() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.AdditionTests.complicatedAddition, a, b, c, d))
            _ = expression.evaluate()
        }
    }

    func testPerformanceSimpleAdditionWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.AdditionTests.simpleAdditionWithParentheses, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceComplicatedAdditionWithSingleParenthesis() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.AdditionTests.complicatedAdditionWithSingleParenthesis, a, b, c, d))
            _ = expression.evaluate()
        }
    }

    func testPerformanceComplicatedAdditionWithMultipleParenthesis() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let e = Int16.random()
        let f = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.AdditionTests.complicatedAdditionWithMultipleParenthesis, a, b, c, d, e, f))
            _ = expression.evaluate()
        }
    }
}
