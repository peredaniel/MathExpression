//  Copyright © 2022 Pedro Daniel Prieto Martínez. Distributed under MIT License.

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
                guard $0.last == "!", let number = Int($0.dropLast()) else { return .zero }
                return Double(number.factorial())
            }
        case .numericValueOrZero:
            return { Double($0) ?? .zero }
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
