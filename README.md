# XCAudit

[![Test](https://github.com/Alexander-Ignition/XCAudit/actions/workflows/test.yml/badge.svg)](https://github.com/Alexander-Ignition/XCAudit/actions/workflows/test.yml)
[![SPM compatible](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)
[![Swift 5.3](https://img.shields.io/badge/swift-5.3-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/Alexander-Ignition/XCAudit/blob/master/LICENSE)

Audit Xcode build logs for GitHub Actions

[Example PR](https://github.com/Alexander-Ignition/XCAudit-Example/pull/2/files)

![test-fail](Images/test-fail.png)

## Requirements

- Swift 5.3
- macOS 10.15

## Example Workflow

```yml
# .github/workflows/test.yml

name: Test
on:
  push:
    branches:
      - main
    tags-ignore:
      - '**'
  pull_request:
    branches:
      - '**'

jobs:
  test:
    name: Run tests
    runs-on: macOS-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Install xcaudit
        uses: Alexander-Ignition/XCAudit@main
      - name: Build and test
        run: swift test --enable-code-coverage --disable-automatic-resolution 2>&1 | xcaudit
        shell: bash
```

## License

MIT
