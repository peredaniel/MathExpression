//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import Foundation
@testable import MathExpression

class RandomExpressionGenerator {
    let inputs: [String: Int] = [
        Formula.AdditionTests.simpleAddition: 2,
        Formula.AdditionTests.complicatedAddition: 4,
        Formula.AdditionTests.simpleAdditionWithParentheses: 2,
        Formula.AdditionTests.complicatedAdditionWithSingleParenthesis: 4,
        Formula.AdditionTests.complicatedAdditionWithMultipleParenthesis: 6,
        Formula.AdditionAndSubtractionTests.simpleOperation: 3,
        Formula.AdditionAndSubtractionTests.simpleOperationWithParentheses: 3,
        Formula.AdditionAndSubtractionTests.simpleOperationWithParenthesesAndInitialMinus: 4,
        Formula.CombinedOperationsTests.productOfAddition: 4,
        Formula.CombinedOperationsTests.productOfSubtraction: 4,
        Formula.CombinedOperationsTests.productOfAdditionWithSubtraction: 4,
        Formula.CombinedOperationsTests.divisionOfAdditionWithSubtraction: 4,
        Formula.CombinedOperationsTests.divisionOfProductOfAdditionsWithProductOfSubtractions: 8,
        Formula.CombinedOperationsTests.divisionOfCrossedProducts: 8,
        Formula.DivisionTests.simpleDivision: 2,
        Formula.DivisionTests.simpleDivisionWithParentheses: 2,
        Formula.DivisionTests.simpleDivisionWithParenthesesWithInitialDivision: 2,
        Formula.DivisionTests.complicatedDivision: 3,
        Formula.DivisionTests.divideSingleNumber: 1,
        Formula.DivisionTests.consecutiveDivisionExpressionWithInitialDivision: 3,
        Formula.ProductAndDivisionTests.simpleOperation: 3,
        Formula.ProductAndDivisionTests.simpleOperationWithParentheses: 3,
        Formula.ProductAndDivisionTests.simpleOperationWithParenthesesAndInitialDivision: 4,
        Formula.ProductAndDivisionTests.complicatedOperationWithParentheses: 6,
        Formula.ProductTests.simpleProduct: 2,
        Formula.ProductTests.complicatedProduct: 4,
        Formula.ProductTests.simpleProductWithParentheses: 2,
        Formula.ProductTests.complicatedProductWithSingleParenthesis: 4,
        Formula.ProductTests.complicatedProductWithMultipleParenthesis: 4,
        Formula.SubtractionTests.simpleSubtraction: 2,
        Formula.SubtractionTests.simpleSubtractionWithParentheses: 2,
        Formula.SubtractionTests.simpleSubtractionWithParenthesesWithInitialMinus: 2,
        Formula.SubtractionTests.complicatedSubtraction: 3,
        Formula.SubtractionTests.negativeSingleNumber: 1,
        Formula.SubtractionTests.negativeExpressionWithInitialMinus: 3
    ]

    func generateRandomExpression(combining numberOfOperationsToCombine: Int) -> String {
        var expression = ""
        var openingBrackets = 0

        for index in 0..<numberOfOperationsToCombine {
            // We randomly select a formula from the preselected set.
            guard let formulaPair = inputs.randomElement() else { continue }

            // We randomly select an operator to connect with the previous formula (if any)
            if index > 0 {
                expression += MathOperator.allCases.randomElement()!.rawValue
            }

            // We generate the formula string with random number values using the auxiliary function.
            let formula = generateString(for: formulaPair)

            // We randomly add an opening bracket (30% chance), or we add it if there's a "-" at the beginning of the
            // formula to prevent a validation failure.
            if UInt8.random(in: 0...100) <= 30 || formula.first == Character(MathOperator.subtraction.rawValue) {
                expression += MathBrackets.parenthesis.opening
                openingBrackets += 1
            }

            expression += formula

            // If there's any open bracket, we randomly add a closing bracket (30% chance).
            if openingBrackets > 0, UInt8.random(in: 0...10) <= 30 {
                expression += MathBrackets.parenthesis.closing
                openingBrackets -= 1
            }
        }

        // In case there is still any open bracket without counterpart, we add closing brackets to match.
        expression += String(repeating: Character(MathBrackets.parenthesis.closing), count: openingBrackets)

        return expression
    }

    private func generateString(for formula: (key: String, value: Int)) -> String {
        var args: [Int16] = []

        for _ in 0..<formula.value {
            args.append(Int16.randomExcludingZero())
        }

        return String(format: formula.key, args)
    }
}
