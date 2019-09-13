//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

enum MathTransformation: CaseIterable {
    case numericValueOrZero
    case count
    case factorial

    var function: (String) -> Double {
        switch self {
        case .count:
            return { Double($0.count) }
        case .factorial:
            return {
                guard $0.last == "!", let number = Int($0.dropLast()) else { return 0.0 }
                return Double(number.factorial())
            }
        case .numericValueOrZero:
            return { Double($0) ?? 0.0 }
        }
    }

    var name: String {
        switch self {
        case .count: return "String count"
        case .factorial: return "Factorial (integers only)"
        case .numericValueOrZero: return "Numeric value or zero"
        }
    }
}
