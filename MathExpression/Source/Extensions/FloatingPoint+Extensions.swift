//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

extension FloatingPoint {
    var inverse: Self {
        return type(of: self).init(1) / self
    }

    var negative: Self {
        var negativeValue = self
        negativeValue.negate()
        return negativeValue
    }

    func avoidScientificNotation() -> String {
        return Formatter.avoidScientificNotation.string(for: self) ?? ""
    }
}
