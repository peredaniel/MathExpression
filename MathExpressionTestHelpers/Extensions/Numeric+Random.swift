//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

extension Int16 {
    static func random() -> Int16 {
        Int16.random(in: Int16.min...Int16.max)
    }

    static func randomEven(in range: ClosedRange<Int16>) -> Int16 {
        let randomValue = random(in: range)
        if randomValue.quotientAndRemainder(dividingBy: 2).remainder == 0 {
            return randomValue
        } else if randomValue > 0 {
            return randomValue - 1
        } else {
            return randomValue + 1
        }
    }

    static func randomOdd(in range: ClosedRange<Int16>) -> Int16 {
        let evenNumber = randomEven(in: range)
        return evenNumber > .zero ? evenNumber - 1 : evenNumber + 1
    }

    static func randomExcludingZero() -> Int16 {
        randomExcluding(.zero)
    }

    static func randomExcluding(_ excluded: Int16) -> Int16 {
        let randomValue = random()
        return randomValue == excluded ? randomExcluding(excluded) : randomValue
    }
}
