// calculator.cj — 一个简单的计算器包，用于演示单元测试
// Calculator Package: basic arithmetic operations for CI/CD demo

package calculator

// Add 返回两个整数的和
public func add(a: Int64, b: Int64): Int64 {
    return a + b
}

// Sub 返回两个整数的差
public func sub(a: Int64, b: Int64): Int64 {
    return a - b
}

// Mul 返回两个整数的积
public func mul(a: Int64, b: Int64): Int64 {
    return a * b
}

// Div 返回两个整数的商 (整数除法)
// 当除数为 0 时返回 Error
public func div(a: Int64, b: Int64): Result<Int64, String> {
    if (b == 0) {
        return Err<Int64, String>("除数不能为零")
    }
    return Ok(a / b)
}

// Factorial 计算 n 的阶乘
// 若 n < 0 返回 Error
public func factorial(n: Int64): Result<Int64, String> {
    if (n < 0) {
        return Err<Int64, String>("负数没有阶乘")
    }
    var result: Int64 = 1
    for (var i: Int64 = 2; i <= n; i++) {
        result *= i
    }
    return Ok(result)
}

// IsPrime 判断一个正整数是否为素数
public func isPrime(n: Int64): Bool {
    if (n <= 1) {
        return false
    }
    var i: Int64 = 2
    while (i * i <= n) {
        if (n % i == 0) {
            return false
        }
        i++
    }
    return true
}

// Gcd 计算两个正整数的最大公约数 (欧几里得算法)
public func gcd(a: Int64, b: Int64): Int64 {
    var x = a
    var y = b
    while (y != 0) {
        let temp = y
        y = x % y
        x = temp
    }
    return x
}

main(): Unit {
    println("欢迎使用仓颉计算器包 — Cangjie Calculator Package v1.0.0")
    println("加法: 3 + 5 = ${add(3, 5)}")
    println("减法: 10 - 7 = ${sub(10, 7)}")
    println("乘法: 4 * 6 = ${mul(4, 6)}")
    let d = div(15, 3)
    if (d is Ok) {
        println("除法: 15 / 3 = ${d.value}")
    }
    println("阶乘: 5! = ${factorial(5).value}")
    println("7 是素数吗? ${isPrime(7)}")
    println("GCD(48, 18) = ${gcd(48, 18)}")
}
