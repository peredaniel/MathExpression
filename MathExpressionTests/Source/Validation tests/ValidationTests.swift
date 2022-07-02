//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class ValidationTests: XCTestCase {
    var a: Int16!
    var b: Int16!
    var c: Int16!
    var d: Int16!
    var e: Int16!

    override func setUp() {
        super.setUp()
        a = Int16.random()
        b = Int16.random()
        c = Int16.random()
        d = Int16.random()
        e = Int16.randomExcluding(d)
    }

    override func tearDown() {
        a = nil
        b = nil
        c = nil
        d = nil
        e = nil
    }

    func testInvalidFormulaThrowsError_emptyExpression() {
        assert(try MathExpression(""), throws: MathExpression.ValidationError.emptyExpression)
    }

    func testInvalidFormulaThrowsError_unevenBracketNumber() {
        let formula = String(format: Formula.ValidationTests.Invalid.unevenBracketNumber, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.unevenOpeningClosingBracketNumber)
    }

    func testInvalidFormulaThrowsError_misplacedBrackets() {
        let formula = String(format: Formula.ValidationTests.Invalid.misplacedBrackets, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.misplacedBrackets)
    }

    func testInvalidFormulaThrowsError_misplacedSumAndClosingBracket() {
        let formula = String(format: Formula.ValidationTests.Invalid.misplacedSumAndClosingBracket, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.endsWithOperator("+"))
    }

    func testInvalidFormulaThrowsError_misplacedSubtractionAndClosingBracket() {
        let formula = String(format: Formula.ValidationTests.Invalid.misplacedSubtractionAndClosingBracket, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.endsWithOperator("-"))
    }

    func testInvalidFormulaThrowsError_misplacedProductAndClosingBracket() {
        let formula = String(format: Formula.ValidationTests.Invalid.misplacedProductAndClosingBracket, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.endsWithOperator("*"))
    }

    func testInvalidFormulaThrowsError_misplacedDivisionAndClosingBracket() {
        let formula = String(format: Formula.ValidationTests.Invalid.misplacedDivisionAndClosingBracket, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.endsWithOperator("/"))
    }

    func testInvalidFormulaThrowsError_misplacedOpeningBracketAndProduct() {
        let formula = String(format: Formula.ValidationTests.Invalid.misplacedOpeningBracketAndProduct, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.startsWithNonSumOrSubtractionOperator("*"))
    }

    func testInvalidFormulaThrowsError_misplacedOpeningBracketAndDivision() {
        let formula = String(format: Formula.ValidationTests.Invalid.misplacedOpeningBracketAndDivision, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.startsWithNonSumOrSubtractionOperator("/"))
    }

    func testInvalidFormulaThrowsError_productFollowedByDivision() {
        let formula = String(format: Formula.ValidationTests.Invalid.productFollowedByDivision, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.invalidConsecutiveOperators("*/"))
    }

    func testInvalidFormulaThrowsError_divisionFollowedByProduct() {
        let formula = String(format: Formula.ValidationTests.Invalid.divisionFollowedByProduct, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.invalidConsecutiveOperators("/*"))
    }

    func testInvalidFormulaThrowsError_consecutiveProducts() {
        let formula = String(format: Formula.ValidationTests.Invalid.consecutiveProducts, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.invalidConsecutiveOperators("**"))
    }

    func testInvalidFormulaThrowsError_consecutiveDivisions() {
        let formula = String(format: Formula.ValidationTests.Invalid.consecutiveDivisions, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.invalidConsecutiveOperators("//"))
    }

    func testInvalidFormulaThrowsError_sumFollowedByProduct() {
        let formula = String(format: Formula.ValidationTests.Invalid.sumFollowedByProduct, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.invalidConsecutiveOperators("+*"))
    }

    func testInvalidFormulaThrowsError_sumFollowedByDivision() {
        let formula = String(format: Formula.ValidationTests.Invalid.sumFollowedByDivision, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.invalidConsecutiveOperators("+/"))
    }

    func testInvalidFormulaThrowsError_subtractionFollowedByProduct() {
        let formula = String(format: Formula.ValidationTests.Invalid.subtractionFollowedByProduct, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.invalidConsecutiveOperators("-*"))
    }

    func testInvalidFormulaThrowsError_subtractionFollowedByDivision() {
        let formula = String(format: Formula.ValidationTests.Invalid.subtractionFollowedByDivision, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.invalidConsecutiveOperators("-/"))
    }

    func testInvalidFormulaThrowsError_startsWithProduct() {
        let formula = String(format: Formula.ValidationTests.Invalid.startsWithProduct, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.startsWithNonSumOrSubtractionOperator("*"))
    }

    func testInvalidFormulaThrowsError_startsWithDivision() {
        let formula = String(format: Formula.ValidationTests.Invalid.startsWithDivision, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.startsWithNonSumOrSubtractionOperator("/"))
    }

    func testInvalidFormulaThrowsError_endsWithSum() {
        let formula = String(format: Formula.ValidationTests.Invalid.endsWithSum, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.endsWithOperator("+"))
    }

    func testInvalidFormulaThrowsError_endsWithSubtraction() {
        let formula = String(format: Formula.ValidationTests.Invalid.endsWithSubtraction, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.endsWithOperator("-"))
    }

    func testInvalidFormulaThrowsError_endsWithProduct() {
        let formula = String(format: Formula.ValidationTests.Invalid.endsWithProduct, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.endsWithOperator("*"))
    }

    func testInvalidFormulaThrowsError_endsWithDivision() {
        let formula = String(format: Formula.ValidationTests.Invalid.endsWithDivision, a, b, c, d, e)

        assert(try MathExpression(formula), throws: MathExpression.ValidationError.endsWithOperator("/"))
    }

    func testValidFormulaNotThrowingError_generic() {
        let formula = String(format: Formula.ValidationTests.Valid.generic, a, b, c, d, e)

        XCTAssertNoThrow(try MathExpression(formula))
    }

    func testValidFormulaNotThrowingError_consecutiveSubtractions() {
        let formula = String(format: Formula.ValidationTests.Valid.consecutiveSubtractions, a, b, c, d, e)

        XCTAssertNoThrow(try MathExpression(formula))
    }

    func testValidFormulaNotThrowingError_consecutiveSums() {
        let formula = String(format: Formula.ValidationTests.Valid.consecutiveSums, a, b, c, d, e)

        XCTAssertNoThrow(try MathExpression(formula))
    }

    func testValidFormulaNotThrowingError_consecutiveSumAndSubtraction() {
        let formula = String(format: Formula.ValidationTests.Valid.consecutiveSumAndSubtraction, a, b, c, d, e)

        XCTAssertNoThrow(try MathExpression(formula))
    }

    func testValidFormulaNotThrowingError_consecutiveSubtractionAndSum() {
        let formula = String(format: Formula.ValidationTests.Valid.consecutiveSubtractionAndSum, a, b, c, d, e)

        XCTAssertNoThrow(try MathExpression(formula))
    }
}
