swift-build = swift build \
	--configuration release \
	--disable-sandbox \
	--arch arm64 \
	--arch x86_64 
	
bin-path := $(shell $(swift-build) --show-bin-path)

build:
	$(swift-build)
	cp $(bin-path)/xcaudit ./Products

install:
	install ./Products/xcaudit /usr/local/bin 

info: 
	lipo -info ./Products/xcaudit

uninstall:
	rm -rf /usr/local/bin/xcaudit

clean:
	swift package clean
