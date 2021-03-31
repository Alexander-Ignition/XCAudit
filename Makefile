swift-build = swift build \
	--configuration release \
	--disable-sandbox \
	--arch arm64 \
	--arch x86_64 
	
bin-path := $(shell $(swift-build) --show-bin-path)

.PHONY: build
build:
	$(swift-build)
	cp $(bin-path)/xcaudit ./Products

.PHONY: install
install:
	install ./Products/xcaudit /usr/local/bin 

.PHONY: info
info: 
	lipo -info ./Products/xcaudit

.PHONY: uninstall
uninstall:
	rm -rf /usr/local/bin/xcaudit

.PHONY: test
test:
	swift test --enable-code-coverage
	xcrun llvm-cov report \
		.build/x86_64-apple-macosx/debug/XCAuditPackageTests.xctest/Contents/MacOS/XCAuditPackageTests \
		-instr-profile=.build/x86_64-apple-macosx/debug/codecov/default.profdata \
		-ignore-filename-regex=Tests

.PHONY: clean
clean:
	swift package clean
