//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class StressPerformanceTests: XCTestCase {
    func testPerformanceFullParenthesesSingleValue() {
        let numberOfParentheses = 500
        var expression = String(repeating: Character(MathBrackets.parenthesis.opening), count: numberOfParentheses)
        expression += "10"
        expression += String(repeating: Character(MathBrackets.parenthesis.closing), count: numberOfParentheses)

        measure {
            let mathExpression = try! MathExpression(expression)
            _ = mathExpression.evaluate()
        }
    }

    func testPerformanceFullParenthesesSumAndProduct() {
        let numberOfParentheses = 500
        var expression = ""
        for _ in 0..<numberOfParentheses {
            expression += "(\(Int.random(in: -100...100)) + \(Int.random(in: -100...100)) * "
        }
        expression += "(\(Int.random(in: -100...100)) + \(Int.random(in: -100...100))"
        expression += String(repeating: Character(MathBrackets.parenthesis.closing), count: numberOfParentheses + 1)
        measure {
            let mathExpression = try! MathExpression(expression)
            _ = mathExpression.evaluate()
        }
    }

    func testPerformanceRandomExpression() {
        let randomGenerator = RandomExpressionGenerator()
        let expression = randomGenerator.generateRandomExpression(combining: 500)

        measure {
            let mathExpression = try! MathExpression(expression)
            _ = mathExpression.evaluate()
        }
    }
}
