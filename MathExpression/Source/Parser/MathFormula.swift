//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

struct MathFormula {
    enum EvaluationState {
        case isNumeric(Double)
        case startsWithSymbol(AdditiveOperator)
        case containsBracket(MathBrackets)
        case canApplyOperator(MathOperator)
        case canApplyTransformation
    }

    private let string: String
    private let transformation: (String) -> Double

    init(
        _ string: String,
        transformation: @escaping (String) -> Double = { Double($0) ?? .zero }
    ) throws {
        self.string = string.trimmingWhiteSpacesAndDoubleMathOperators()
        self.transformation = transformation
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
        Double(string)
    }

    func evaluationState(validating: Bool = false) -> EvaluationState {
        if let value = asDouble {
            return .isNumeric(value)
        }

        for additiveOperator in AdditiveOperator.allCases {
            if starts(with: additiveOperator) {
                return .startsWithSymbol(additiveOperator)
            }
        }

        for brackets in MathBrackets.allCases {
            if containsBracket(brackets) {
                return .containsBracket(brackets)
            }
        }

        if let firstOperator = getFirstOperator(validating: validating) {
            return .canApplyOperator(firstOperator)
        }

        return .canApplyTransformation
    }

    func getFirstOperator(validating: Bool = false) -> MathOperator? {
        let cases = validating ? MathOperator.validationCases : MathOperator.evaluationCases
        return cases.first { string.contains($0.rawValue) }
    }
}

// MARK: - Functions

extension MathFormula {
    func applyTransformation() -> Double {
        transformation(string)
    }

    func decompose(with mathOperator: MathOperator) -> [MathFormula] {
        var finalString = string
        if let _ = MathOperator.validConsecutiveOperatorsDuringEvaluation.first(where: { string.contains($0.key) }) {
            for (doubleOperator, combinedOperator) in MathOperator.validConsecutiveOperatorsDuringEvaluation {
                finalString = finalString.replacingOccurrences(of: doubleOperator, with: combinedOperator)
            }
        }
        return finalString.split(separator: mathOperator.character).map {
            MathFormula(validString: String($0), transformation: transformation)
        }
    }

    func dropingInitialValue() -> MathFormula {
        MathFormula(
            validString: String(string.dropFirst()),
            transformation: transformation
        )
    }

    func evaluatingExpression(between bracket: MathBrackets) -> MathFormula {
        let stringWithBrackets = (try? getString(between: bracket)) ?? ""

        let value = MathExpression(
            MathFormula(
                validString: String(stringWithBrackets.dropFirst().dropLast()),
                transformation: transformation
            )
        ).evaluate()
        return MathFormula(
            validString: string.replacingOccurrences(of: stringWithBrackets, with: value.avoidScientificNotation()),
            transformation: transformation
        )
    }

    func replaceSubtractionByNegative() -> MathFormula {
        return MathFormula(
            validString: MathOperator.negative.rawValue + String(string.dropFirst()),
            transformation: transformation
        )
    }
}

// MARK: - Private API

private extension MathFormula {
    func containsBracket(_ bracket: MathBrackets) -> Bool {
        string.contains(bracket.opening) || string.contains(bracket.closing)
    }

    func getString(between bracket: MathBrackets) throws -> String {
        try String(string.map { $0 }.characters(between: bracket))
    }

    func starts(with additiveOperator: AdditiveOperator) -> Bool {
        string.first == additiveOperator.character
    }

    func validate() throws {
        guard !string.isEmpty else {
            throw MathExpression.ValidationError.emptyExpression
        }

        try string.validateStartingAndEndingCharacters()
        try string.validateNoInvalidConsecutiveOperators()

        switch evaluationState(validating: true) {
        case .isNumeric:
            break
        case .startsWithSymbol(let symbol):
            switch symbol {
            case .sum:
                _ = try MathFormula(String(string.dropFirst()), transformation: transformation)
            case .subtraction:
                _ = try MathFormula(MathOperator.negative.rawValue + String(string.dropFirst()), transformation: transformation)
            }
        case .containsBracket(let brackets):
            let stringWithBrackets = try getString(between: brackets)
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

        if MathOperator.validationCases.map({ $0.rawValue }).contains(String(last)) {
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
