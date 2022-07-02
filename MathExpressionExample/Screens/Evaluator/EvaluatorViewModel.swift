//  Copyright © 2022 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import Foundation
import MathExpression

class EvaluatorViewModel: ObservableObject {
    @Published var operationResult: String = ""
    @Published var shouldShowError: Bool = false

    @Published var expression: String = "" {
        didSet { operationResult = "" }
    }
    @Published var transformation: MathTransformation = .numericValueOrZero

    private(set) var operationError: ValidationError?

    func evaluateExpression() {
        do {
            let mathExpression = try MathExpression(expression, transformation: transformation.function)
            let result = Formatter.mathExpression.string(from: NSNumber(value: mathExpression.evaluate())) ?? ""
            operationResult = "The evaluation result is: \(result)"
        } catch {
            guard let error = error as? MathExpression.ValidationError else {
                fatalError("[EvaluatorViewModel] Expression \(expression) returned unknown error during validation!")
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
