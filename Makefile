# Makefile

TOOL_NAME=AvocadoToast

# local config
SWIFT_BUILD=swift build
SWIFT_CLEAN=swift package clean
SWIFT_BUILD_DIR=.build
SWIFT_TEST=swift test
CONFIGURATION=release

# docker config
DOCKER_BUILD_DIR=".docker.build"
#SWIFT_BUILD_IMAGE="swift:5.5.3"
SWIFT_BUILD_IMAGE="helje5/arm64v8-swift-dev:5.5.3"
SWIFT_DOCKER_BUILD_DIR="$(DOCKER_BUILD_DIR)/aarch64-unknown-linux/$(CONFIGURATION)"
#SWIFT_DOCKER_BUILD_DIR="$(DOCKER_BUILD_DIR)/x86_64-unknown-linux/$(CONFIGURATION)"
DOCKER_BUILD_PRODUCT="$(DOCKER_BUILD_DIR)/$(TOOL_NAME)"


SWIFT_SOURCES=\
	Sources/*/*/*.swift \
	Sources/*/*/*/*.swift

all:
	$(SWIFT_BUILD) -c $(CONFIGURATION)

# Cannot test in `release` configuration?!
test:
	$(SWIFT_TEST) 
	
clean :
	$(SWIFT_CLEAN)
	# We have a different definition of "clean", might be just German
	# pickyness.
	rm -rf $(SWIFT_BUILD_DIR) 

$(DOCKER_BUILD_PRODUCT): $(SWIFT_SOURCES)
	time docker run --rm \
          -v "$(PWD):/src" \
          -v "$(PWD)/$(DOCKER_BUILD_DIR):/src/.build" \
          "$(SWIFT_BUILD_IMAGE)" \
          bash -c 'cd /src && swift build -c $(CONFIGURATION)'
	ls -lah $(DOCKER_BUILD_PRODUCT)

docker-all: $(DOCKER_BUILD_PRODUCT)


docker-clean:
	rm -rf $(DOCKER_BUILD_PRODUCT)	
	
docker-distclean:
	rm -rf $(DOCKER_BUILD_DIR)

distclean: clean docker-distclean

docker-run:
	docker run --rm -it -p "127.0.0.1:1337:1337" \
		  --name $(TOOL_NAME) \
	          -v "$(PWD):/src" \
	          -v "$(PWD)/$(DOCKER_BUILD_DIR):/src/.build" \
	          "$(SWIFT_BUILD_IMAGE)" \
		  /src/$(SWIFT_BUILD_DIR)/x86_64-unknown-linux/$(CONFIGURATION)/$(TOOL_NAME)

docker-emacs:
	docker run --rm -it \
	          -v "$(PWD):/src" \
	          -v "$(PWD)/$(DOCKER_BUILD_DIR):/src/.build" \
	          "$(SWIFT_BUILD_IMAGE)" \
		  emacs /src
