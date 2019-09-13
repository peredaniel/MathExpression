//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import Foundation

extension FloatingPoint {
    var negative: Self {
        var negativeValue = self
        negativeValue.negate()
        return negativeValue
    }

    func avoidScientificNotation() -> String {
        return Formatter.avoidScientificNotation.string(for: self) ?? ""
    }
}
