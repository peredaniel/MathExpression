//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class StressPerformanceTests: XCTestCase {
    func testPerformanceFullParenthesesSumAndProduct() {
        let numberOfParentheses = 500
        var expression = ""
        for _ in 0..<numberOfParentheses {
            expression += "(\(Int.random(in: -100...100)) + \(Int.random(in: -100...100)) * "
        }
        expression += "(\(Int.random(in: -100...100)) + \(Int.random(in: -100...100))"
        for _ in 0...numberOfParentheses {
            expression += ")"
        }
        measure {
            let mathExpression = try! MathExpression(expression)
            _ = mathExpression.evaluate()
        }
    }

    func testPerformanceFullParentheses() {
        let numberOfParentheses = 500
        var expression = ""
        for _ in 0..<numberOfParentheses {
            expression += "("
        }
        expression += "10"
        for _ in 0..<numberOfParentheses {
            expression += ")"
        }
        measure {
            let mathExpression = try! MathExpression(expression)
            _ = mathExpression.evaluate()
        }
    }
}
