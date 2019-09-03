//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import Foundation

enum MathOperator: String, CaseIterable {
    case product = "*"
    case division = "/"
    case sum = "+"
    case subtraction = "-"

    var neutralElement: String {
        switch self {
        case .sum, .subtraction: return "0"
        case .product, .division: return "1"
        }
    }

    static var additiveOperators: [MathOperator] {
        return [.sum, .subtraction]
    }

    static var multiplicativeOperators: [MathOperator] {
        return [.product, .division]
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
        }
    }
}

// MARK: - Helper extensions

private extension Array where Element == Double {
    func sum() -> Element {
        guard let last = last else { return 0.0 }
        return last + dropLast().sum()
    }

    func subtract() -> Double {
        guard let first = first else { return 0.0 }
        return first + reversed().dropLast().map { $0.negative }.sum()
    }

    func multiply() -> Double {
        guard !contains(0.0) else { return 0.0 }
        guard let last = last else { return 1.0 }
        return last * dropLast().multiply()
    }

    func divide() -> Double {
        guard let numerator = first else { return 1.0 }
        return numerator / reversed().dropLast().multiply()
    }
}
