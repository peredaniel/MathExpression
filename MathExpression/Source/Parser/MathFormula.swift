//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

struct MathFormula {
    enum EvaluationState {
        case isNumeric(Double)
        case startsWithSymbol(MathOperator)
        case containsBracket(MathBrackets)
        case canApplyOperator(MathOperator)
        case canApplyTransformation
    }

    private let string: String
    private let transformation: (String) -> Double

    init(
        _ string: String,
        transformation: ((String) -> Double)? = nil
    ) throws {
        self.string = string.trimmingWhiteSpacesAndDoubleMathOperators()
        self.transformation = transformation ?? { Double($0) ?? 0.0 }
        try validate()
    }

    init(
        validString string: String,
        transformation: @escaping (String) -> Double
    ) {
        self.string = string.trimmingWhiteSpacesAndDoubleMathOperators()
        self.transformation = transformation
    }
}

// MARK: - Computed properties

extension MathFormula {
    var asDouble: Double? {
        return Double(string)
    }

    var evaluationState: EvaluationState {
        if let value = asDouble {
            return .isNumeric(value)
        }

        for mathOperator in MathOperator.additiveOperators {
            if starts(with: mathOperator) {
                return .startsWithSymbol(mathOperator)
            }
        }

        for brackets in MathBrackets.allCases {
            if containsBracket(brackets) {
                return .containsBracket(brackets)
            }
        }

        if let firstOperator = firstOperator {
            return .canApplyOperator(firstOperator)
        }

        return .canApplyTransformation
    }

    var firstOperator: MathOperator? {
        return MathOperator.allCases.first { string.contains($0.rawValue) }
    }
}

// MARK: - Functions

extension MathFormula {
    func addingInitialValue(for mathOperator: MathOperator) -> MathExpression {
        return MathExpression(
            validString: mathOperator.neutralElement + string,
            transformation: transformation
        )
    }

    func applyTransformation() -> Double {
        return transformation(string)
    }

    func decompose(with mathOperator: MathOperator) -> [MathExpression] {
        return string.split(separator: mathOperator.character).map {
            MathExpression(validString: String($0), transformation: transformation)
        }
    }

    func dropingInitialValue() -> MathExpression {
        return MathExpression(
            validString: String(string.dropFirst()),
            transformation: transformation
        )
    }

    func evaluatingExpression(between bracket: MathBrackets) -> MathExpression {
        guard let stringWithBrackets = try? getString(between: bracket) else {
            return MathExpression(validString: string, transformation: transformation)
        }

        let value = MathExpression(
            validString: String(stringWithBrackets.dropFirst().dropLast()),
            transformation: transformation
        ).evaluate()
        return MathExpression(
            validString: string.replacingOccurrences(of: stringWithBrackets, with: value.avoidScientificNotation()),
            transformation: transformation
        )
    }
}

// MARK: - Private API

private extension MathFormula {
    func containsBracket(_ bracket: MathBrackets) -> Bool {
        return string.contains(bracket.opening) || string.contains(bracket.closing)
    }

    func getString(between bracket: MathBrackets) throws -> String? {
        return try String(string.map { $0 }.characters(between: bracket))
    }

    func starts(with mathOperator: MathOperator) -> Bool {
        return string.first == mathOperator.character
    }

    func validate() throws {
        guard !string.isEmpty else {
            throw MathExpression.ValidationError.emptyExpression
        }

        try string.validateStartingAndEndingCharacters()
        try string.validateNoInvalidConsecutiveOperators()

        switch evaluationState {
        case .isNumeric:
            break
        case .startsWithSymbol(let symbol):
            switch symbol {
            case .sum, .product:
                _ = try MathFormula(String(string.dropFirst()), transformation: transformation)
            case .subtraction, .division:
                _ = try MathFormula(symbol.neutralElement + string, transformation: transformation)
            }
        case .containsBracket(let brackets):
            guard let stringWithBrackets = try getString(between: brackets) else {
                return
            }
            _ = try MathFormula(
                String(stringWithBrackets.dropFirst().dropLast()),
                transformation: transformation
            )
            _ = try MathFormula(
                string.replacingOccurrences(of: stringWithBrackets, with: "0"),
                transformation: transformation
            )

        case .canApplyOperator(let mathOperator):
            _ = try string.split(separator: mathOperator.character).map {
                try MathFormula(String($0), transformation: transformation)
            }
        case .canApplyTransformation:
            break
        }
    }
}

// MARK: - Helper extensions

private extension String {
    func trimmingWhiteSpacesAndDoubleMathOperators() -> String {
        var finalString = replacingOccurrences(of: " ", with: "")
        for (doubleOperator, combinedOperator) in MathOperator.validConsecutiveOperators {
            finalString = finalString.replacingOccurrences(of: doubleOperator, with: combinedOperator)
        }
        return finalString
    }

    func validateNoInvalidConsecutiveOperators() throws {
        for consecutiveOperators in MathOperator.invalidConsecutiveOperators {
            if let _ = range(of: consecutiveOperators) {
                throw MathExpression.ValidationError.consecutiveMultiplicativeOperators(consecutiveOperators)
            }
        }
    }

    func validateStartingAndEndingCharacters() throws {
        guard let first = first, let last = last else { return }
        if MathOperator.multiplicativeOperators.map({ $0.rawValue }).contains(String(first)) {
            throw MathExpression.ValidationError.startsWithNonSumOrSubtractionOperator(String(first))
        }

        if MathOperator.allCases.map({ $0.rawValue }).contains(String(last)) {
            throw MathExpression.ValidationError.endsWithOperator(String(last))
        }
    }
}

private extension Array where Element == String.Element {
    func characters(between brackets: MathBrackets) throws -> [Character] {
        guard let initialIndex = lastIndex(of: Character(brackets.opening)) else {
            throw MathExpression.ValidationError.unevenOpeningClosingBracketNumber
        }

        guard let finalIndex = self[initialIndex..<count].firstIndex(of: Character(brackets.closing)) else {
            throw MathExpression.ValidationError.misplacedBrackets
        }

        return Array(self[initialIndex...finalIndex])
    }
}
