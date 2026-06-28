// calculator_test.cj — 计算器包的完整单元测试
// Calculator Unit Tests using std.unittest framework

package calculator_test

import std.unittest.*
import std.unittest.testmacro.*
import calculator.*

// ============================================================
// 测试类 1: 基本四则运算测试
// ============================================================
@Test
@Tag("Smoke")
public class TestBasicArithmetic {
    @TestCase
    @Tag("Smoke")
    func testAdd(): Unit {
        @Assert(add(1, 2), 3)
        @Assert(add(-1, 1), 0)
        @Assert(add(0, 0), 0)
        @Assert(add(100, 200), 300)
        @Assert(add(-5, -3), -8)
    }

    @TestCase
    @Tag("Smoke")
    func testSub(): Unit {
        @Assert(sub(5, 3), 2)
        @Assert(sub(0, 0), 0)
        @Assert(sub(10, 20), -10)
        @Assert(sub(-5, -3), -2)
    }

    @TestCase
    @Tag("Smoke")
    func testMul(): Unit {
        @Assert(mul(3, 4), 12)
        @Assert(mul(0, 100), 0)
        @Assert(mul(-2, 5), -10)
        @Assert(mul(-3, -3), 9)
    }

    @TestCase
    func testDiv(): Unit {
        let r1 = div(10, 2)
        @Assert(r1 is Ok, true)
        @Assert(r1.value, 5)

        let r2 = div(7, 2)
        @Assert(r2 is Ok, true)
        @Assert(r2.value, 3) // 整数除法

        let r3 = div(0, 5)
        @Assert(r3 is Ok, true)
        @Assert(r3.value, 0)
    }

    @TestCase
    func testDivByZero(): Unit {
        let r = div(10, 0)
        @Assert(r is Err, true)
    }
}

// ============================================================
// 测试类 2: 阶乘测试
// ============================================================
@Test
public class TestFactorial {
    @TestCase
    func testFactorialBaseCases(): Unit {
        let r0 = factorial(0)
        @Assert(r0 is Ok, true)
        @Assert(r0.value, 1)   // 0! = 1

        let r1 = factorial(1)
        @Assert(r1 is Ok, true)
        @Assert(r1.value, 1)   // 1! = 1
    }

    @TestCase
    func testFactorialNormal(): Unit {
        @Assert(factorial(5).value, 120)   // 5! = 120
        @Assert(factorial(6).value, 720)   // 6! = 720
        @Assert(factorial(10).value, 3628800) // 10! = 3628800
    }

    @TestCase
    func testFactorialNegative(): Unit {
        let r = factorial(-5)
        @Assert(r is Err, true)
    }
}

// ============================================================
// 测试类 3: 素数判断测试
// ============================================================
@Test
public class TestIsPrime {
    @TestCase
    @Tag("Smoke")
    func testSmallNumbers(): Unit {
        @Assert(isPrime(0), false)
        @Assert(isPrime(1), false)
        @Assert(isPrime(2), true)
        @Assert(isPrime(3), true)
        @Assert(isPrime(4), false)
    }

    @TestCase
    func testKnownPrimes(): Unit {
        @Assert(isPrime(7), true)
        @Assert(isPrime(13), true)
        @Assert(isPrime(17), true)
        @Assert(isPrime(19), true)
        @Assert(isPrime(97), true)
    }

    @TestCase
    func testKnownComposites(): Unit {
        @Assert(isPrime(9), false)
        @Assert(isPrime(15), false)
        @Assert(isPrime(21), false)
        @Assert(isPrime(100), false)
        @Assert(isPrime(1000), false)
    }
}

// ============================================================
// 测试类 4: 最大公约数测试 (参数化测试)
// ============================================================
@Test
public class TestGcd {
    @TestCase
    func testGcdBasic(): Unit {
        @Assert(gcd(48, 18), 6)
        @Assert(gcd(100, 75), 25)
        @Assert(gcd(17, 13), 1)  // 互质
        @Assert(gcd(1, 1), 1)
    }

    @TestCase
    func testGcdWithZero(): Unit {
        @Assert(gcd(0, 5), 5)
        @Assert(gcd(10, 0), 10)
        @Assert(gcd(0, 0), 0)
    }

    @TestCase
    func testGcdLargeNumbers(): Unit {
        @Assert(gcd(1000000, 500000), 500000)
        @Assert(gcd(999999, 777777), 111111)
    }
}

// ============================================================
// 测试类 5: 综合集成测试
// ============================================================
@Test
@Tag("Integration")
public class TestIntegration {
    @TestCase
    @Tag("Integration")
    func testCalculateExpression(): Unit {
        // 测试: (10 + 5) * 3 - 20 / 4 = 45 - 5 = 40
        let step1 = add(10, 5)     // 15
        let step2 = mul(step1, 3)  // 45
        let step3 = div(20, 4).value // 5
        let result = sub(step2, step3) // 40
        @Assert(result, 40)
    }

    @TestCase
    @Tag("Integration")
    func testFactorialDividedByGCD(): Unit {
        // 5! / gcd(48, 18) = 120 / 6 = 20
        let fact5 = factorial(5).value
        let g = gcd(48, 18)
        let result = div(fact5, g).value
        @Assert(result, 20)
    }
}
