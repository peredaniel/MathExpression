//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import XCTest

class CombinedOperationsTests: XCTestCase {
    func testProductOfAddition() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let operation = Operation(
            String(format: Formula.CombinedOperationsTests.productOfAddition, a, b, c, d),
            expectedResult: (Double(a) + Double(b)) * (Double(c) + Double(d))
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testSquareOfAddition() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.CombinedOperationsTests.productOfAddition, a, b, a, b),
            expectedResult: pow(Double(a) + Double(b), 2.0)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testProductOfSubtraction() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let operation = Operation(
            String(format: Formula.CombinedOperationsTests.productOfSubtraction, a, b, c, d),
            expectedResult: (Double(a) - Double(b)) * (Double(c) - Double(d))
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testSquareOfSubtraction() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.CombinedOperationsTests.productOfSubtraction, a, b, a, b),
            expectedResult: pow(Double(a) - Double(b), 2.0)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testProductOfAdditionWithSubtraction() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.randomExcluding(c)
        let operation = Operation(
            String(format: Formula.CombinedOperationsTests.productOfAdditionWithSubtraction, a, b, c, d),
            expectedResult: (Double(a) + Double(b)) * (Double(c) - Double(d))
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testProductOfAdditionWithSubtractionIdentity() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.CombinedOperationsTests.productOfAdditionWithSubtraction, a, b, a, b),
            expectedResult: pow(Double(a), 2.0) - pow(Double(b), 2.0)
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testDivisionOfAdditionWithSubtraction() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.randomExcluding(c)
        let operation = Operation(
            String(format: Formula.CombinedOperationsTests.divisionOfAdditionWithSubtraction, a, b, c, d),
            expectedResult: (Double(a) + Double(b)) / (Double(c) - Double(d))
        )
        XCTAssertEqual(operation.compute(), operation.expectedResult)
    }

    func testDivisionOfProductOfAdditionsWithProductOfSubtractions() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let e = Int16.random()
        let f = Int16.randomExcluding(e)
        let g = Int16.random()
        let h = Int16.randomExcluding(g)
        let operation = Operation(
            String(format: Formula.CombinedOperationsTests.divisionOfProductOfAdditionsWithProductOfSubtractions, a, b, c, d, e, f, g, h),
            expectedResult: (Double(a) + Double(b)) * (Double(c) + Double(d)) / ((Double(e) - Double(f)) * (Double(g) - Double(h)))
        )
        XCTAssertEqual(operation.compute().rounded(toPlaces: 6), operation.expectedResult.rounded(toPlaces: 6))
    }

    func testDivisionOfCrossedProducts() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let e = Int16.random()
        let f = Int16.random()
        let g = Int16.random()
        let h = Int16.randomExcluding(g)
        let operation = Operation(
            String(format: Formula.CombinedOperationsTests.divisionOfCrossedProducts, a, b, c, d, e, f, g, h),
            expectedResult: (Double(a) + Double(b)) * (Double(c) - Double(d)) / ((Double(e) + Double(f)) * (Double(g) - Double(h)))
        )
        XCTAssertEqual(operation.compute().rounded(toPlaces: 6), operation.expectedResult.rounded(toPlaces: 6))
    }
}
