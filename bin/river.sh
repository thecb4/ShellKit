#!/usr/bin/env sh

swiftformat --swiftversion 5.1 .
swiftlint lint .
swift test --generate-linuxmain && swift test --enable-code-coverage
