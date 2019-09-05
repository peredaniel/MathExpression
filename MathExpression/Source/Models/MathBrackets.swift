//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

enum MathBrackets: CaseIterable {
    case parenthesis

    var opening: String {
        switch self {
        case .parenthesis: return "("
        }
    }

    var closing: String {
        switch self {
        case .parenthesis: return ")"
        }
    }
}
