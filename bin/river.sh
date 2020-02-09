#!/usr/bin/env sh

git add . && \
swift test --generate-linuxmain && \
swiftformat --swiftversion 5.1 . && \
swiftlint lint . && \
swift test --enable-code-coverage && \
git commit -F commit.yml
