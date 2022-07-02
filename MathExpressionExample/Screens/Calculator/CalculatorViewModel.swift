//  Copyright © 2022 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import Foundation
import MathExpression

class CalculatorViewModel: ObservableObject {
    @Published var operationResult: String = "0"
    @Published var shouldShowError: Bool = false
    @Published var expression: String = ""
    @Published var clearButtonTitle: String = "AC"
    @Published var lastKeyTapped: String? {
        didSet { parseLastKeyTapped(lastKeyTapped) }
    }

    private(set) var operationError: ValidationError?
    private var shouldClearNewCharactersOnNextTap: Bool = true

    func reset() {
        shouldShowError = false
        expression = ""
        operationResult = "0"
        operationError = nil
        clearButtonTitle = "AC"
        shouldClearNewCharactersOnNextTap = true
        lastKeyTapped = nil
    }
}

private extension CalculatorViewModel {
    func parseLastKeyTapped(_ value: String?) {
        switch value {
        case "=":
            if !expression.isEmpty, expression.last != ")" {
                updateExpression(operationResult)
            }
            evaluateExpression()
        case "+/-":
            guard !operationResult.isEmpty, operationResult != "0" else { return }
            if operationResult.starts(with: "-") {
                operationResult = String(operationResult.dropFirst())
            } else {
                operationResult = "-\(operationResult)"
            }
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            if operationResult == "0" || shouldClearNewCharactersOnNextTap {
                operationResult = value ?? ""
                clearButtonTitle = "C"
                shouldClearNewCharactersOnNextTap = false
            } else if expression.last == "=" {
                expression = ""
            } else {
                operationResult += (value ?? "")
            }
        case "+", "-", "*", "/":
            if shouldClearNewCharactersOnNextTap {
                expression = ""
            }
            if expression.last != ")", operationResult != "0" {
                updateExpression(operationResult)
            }
            updateExpression(value)
            shouldClearNewCharactersOnNextTap = true
        case "(", ")":
            if value == ")" {
                updateExpression(operationResult)
            } else {
                shouldClearNewCharactersOnNextTap = true
            }
            updateExpression(value)
        case "AC":
            operationResult = "0"
            expression = ""
        case "C":
            operationResult = "0"
            clearButtonTitle = "AC"
        case ".":
            operationResult += "."
        default:
            break
        }
    }

    func updateExpression(_ newCharacters: String?) {
        guard let newCharacters = newCharacters else { return }
        if !expression.isEmpty, expression.last != "(", newCharacters != ")" {
            expression += " \(newCharacters)"
        } else {
            expression += newCharacters
        }
    }

    func evaluateExpression() {
        do {
            let mathExpression = try MathExpression(expression, transformation: MathTransformation.numericValueOrZero.function)
            let result = Formatter.mathExpression.string(from: NSNumber(value: mathExpression.evaluate())) ?? ""
            operationResult = result
            updateExpression("=")
            shouldClearNewCharactersOnNextTap = true
            clearButtonTitle = "AC"
        } catch {
            guard let error = error as? MathExpression.ValidationError else {
                fatalError("[CalculatorViewModel] Expression \(expression) returned unknown error during validation!")
            }
            switch error {
            case .emptyExpression:
                operationError = ValidationError("The expression is empty!")
            case .misplacedBrackets:
                operationError = ValidationError("There is a bracket out of place.")
            case .unevenOpeningClosingBracketNumber:
                operationError = ValidationError("The number of opening and closing brackets is uneven!")
            case .invalidConsecutiveOperators(let value):
                operationError = ValidationError("The combination of operators \(value) is not valid.")
            case .startsWithNonSumOrSubtractionOperator(let value):
                operationError = ValidationError("The expression can not start with the \(value) operator.")
            case .endsWithOperator(let value):
                operationError = ValidationError("The expression can not end with the \(value) operator.")
            }
            shouldShowError = true
        }
    }
}
