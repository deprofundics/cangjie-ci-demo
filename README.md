# 仓颉 CI/CD 单元测试演示项目

## 项目简介

本项目演示如何在 **GitHub Actions** 流水线上搭建**仓颉编程语言（Cangjie）**的单元测试环境，并完成自动化测试。

## 项目结构

```
cangjie-ci-demo/
├── cjpm.toml                           # 项目配置 & CI profile
├── .github/workflows/ci.yml            # GitHub Actions CI/CD 流水线
├── src/
│   └── calculator/
│       ├── calculator.cj               # 计算器包实现
│       └── calculator_test.cj          # 计算器包单元测试
└── README.md
```

## 技术栈

| 组件 | 说明 |
|------|------|
| **仓颉编程语言 (Cangjie)** | 华为自研编程语言, v1.0.0 |
| **CJPM** | 仓颉包管理工具 (类似 Rust Cargo) |
| **std.unittest** | 仓颉标准库单元测试框架 |
| **GitHub Actions** | CI/CD 流水线平台 |
| **Zxilly/setup-cangjie** | 仓颉工具链安装 Action |
| **cjcov** | 仓颉代码覆盖率工具 |

## CI/CD 流水线说明

流水线定义在 `.github/workflows/ci.yml`，包含两个 Job:

### Job 1: `build-and-test` (Ubuntu)
1. 代码检出 → 2. 安装仓颉工具链 → 3. 编译检查 → 4. 全量单元测试 → 5. 冒烟测试 → 6. 集成测试 → 7. 覆盖率统计 → 8. 上传产物

### Job 2: `build-matrix` (多平台)
- 在 Ubuntu / macOS / Windows 三平台并行编译验证

## 本地运行

```bash
# 编译
cjpm build

# 运行全量测试
cjpm test

# 运行冒烟测试
cjpm test --include-tags=Smoke

# 运行集成测试
cjpm test --include-tags=Integration

# 测试 + 覆盖率
cjpm test --coverage
cjcov --root=./ --html-details -o coverage-html

# 生成 XML 报告
cjpm test --report-path=test-reports --report-format=xml
```

## 测试用例统计

| 测试类 | 测试方法数 | 标签 |
|--------|-----------|------|
| TestBasicArithmetic | 5 | Smoke (部分) |
| TestFactorial | 3 | — |
| TestIsPrime | 3 | Smoke (部分) |
| TestGcd | 3 | — |
| TestIntegration | 2 | Integration |
| **合计** | **16** | |
