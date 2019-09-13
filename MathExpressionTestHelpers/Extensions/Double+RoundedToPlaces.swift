//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import Foundation

extension Double {
    func rounded(
        toPlaces places: Int,
        roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
    ) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded(roundingRule) / divisor
    }
}
