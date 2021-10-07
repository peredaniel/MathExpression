//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import Foundation

enum AdditiveOperator: String, CaseIterable {
    case sum = "+"
    case subtraction = "-"

    var character: Character {
        return Character(rawValue)
    }
}

enum MathOperator: String {
    case negative = "_"
    case product = "*"
    case division = "/"
    case sum = "+"
    case subtraction = "-"

    static var evaluationCases: [MathOperator] {
        return [.sum, .subtraction, .product, .division, .negative]
    }

    static var multiplicativeOperators: [MathOperator] {
        return [.product, .division]
    }

    static var validationCases: [MathOperator] {
        return [.product, .division, .sum, .subtraction]
    }
}

// MARK: - Static variables

extension MathOperator {
    static var validConsecutiveOperators: [String: String] {
        return [
            MathOperator.sum.rawValue + MathOperator.subtraction.rawValue: MathOperator.subtraction.rawValue,
            MathOperator.subtraction.rawValue + MathOperator.sum.rawValue: MathOperator.subtraction.rawValue,
            MathOperator.sum.rawValue + MathOperator.sum.rawValue: MathOperator.sum.rawValue,
            MathOperator.subtraction.rawValue + MathOperator.subtraction.rawValue: MathOperator.sum.rawValue
        ]
    }

    static var validConsecutiveOperatorsDuringEvaluation: [String: String] {
        return [
            MathOperator.negative.rawValue + MathOperator.sum.rawValue: MathOperator.negative.rawValue,
            MathOperator.negative.rawValue + MathOperator.subtraction.rawValue: MathOperator.sum.rawValue,
            MathOperator.sum.rawValue + MathOperator.subtraction.rawValue: MathOperator.sum.rawValue + MathOperator.negative.rawValue,
            MathOperator.product.rawValue + MathOperator.subtraction.rawValue: MathOperator.product.rawValue + MathOperator.negative.rawValue,
            MathOperator.division.rawValue + MathOperator.subtraction.rawValue: MathOperator.division.rawValue + MathOperator.negative.rawValue
        ]
    }

    static var invalidConsecutiveOperators: [String] {
        return [
            MathOperator.product.rawValue + MathOperator.product.rawValue,
            MathOperator.division.rawValue + MathOperator.division.rawValue
        ]
    }
}

// MARK: - Computed variables

extension MathOperator {
    var character: Character {
        return Character(rawValue)
    }

    func apply(to args: [Double]) -> Double {
        switch self {
        case .sum: return args.sum()
        case .subtraction: return args.subtract()
        case .product: return args.multiply()
        case .division: return args.divide()
        case .negative: return args.first?.negative ?? .zero
        }
    }
}

// MARK: - Helper extensions

private extension Array where Element == Double {
    func sum() -> Element {
        guard let last = last else { return .zero }
        return last + dropLast().sum()
    }

    func subtract() -> Double {
        guard let first = first else { return .zero }
        return first + reversed().dropLast().map { $0.negative }.sum()
    }

    func multiply() -> Double {
        guard !contains(.zero) else { return .zero }
        guard let last = last else { return 1.0 }
        return last * dropLast().multiply()
    }

    func divide() -> Double {
        guard let numerator = first else { return 1.0 }
        return numerator / reversed().dropLast().multiply()
    }
}
