#!/usr/bin/make -f
#
#  Makefile for system wide installation
#
ifneq (,)
$(error This makefile requires GNU Make.)
endif

include ../../mk/hello.mk

# Rule: make ---------- Build go source
all:
	@echo "Building $(PACKAGE)"
	@vgo build


# Rule: goinstall ----- Do local install
goinstall:
	@echo "Writing $$GOPATH/bin/$(PACKAGE)"
	@vgo install


# Rule: run ----------- Test and execute source
run:
	@vgo test
	@vgo run $(SRC_FILE_NAME)


# Rule: install-bin --- System wide binary install (sudo)
install-bin: all $(PACKAGE)

$(PACKAGE): install-dirs
	@sudo install -m 0755 $@ $(BINDIR)/$@
	@echo "Writing $(BINDIR)/$@"

install-dirs:
	@sudo install -d $(BINDIR)


# Rule: clean --------- Remove go build artifacts
clean:
	@rm -fv $(PACKAGE)


# Rule: help ---------- Display Makefile rules
help:
	@grep "^# Rule:" Makefile | sort


.PHONY: install-bin install-dirs help clean run goinstall

