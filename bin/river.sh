#!/usr/bin/env sh

swift test --generate-linuxmain && \
swiftformat --swiftversion 5.1 . && \
swiftlint lint . && \
swift test --enable-code-coverage && \
git add . && git commit -m "$1"
