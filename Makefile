#!/usr/bin/make -f
#
# Top level Makefile
#
ifneq (,)
$(error This makefile requires GNU Make.)
endif

include mk/hello.mk

# Version for archive name
VERSION     = $(shell head -n 1 $(CHANGES_FILE) | awk '{print $2}' | grep -o '[0-9].[0-9].[0-9]')
ifeq ($(VERSION),)
VERSION     = $(shell date +%y%m%d.%H%M)
endif
RELEASE     = $(PACKAGE)-$(VERSION)


# Ensure go.mod exist
GOMOD := $(shell test -f go.mod && echo $?)
ifndef GOMOD
$(shell touch go.mod)
endif


# Rule: all ----------- Build all go artifacts
all:
	@cd $(DOCS_DIR) && $(MAKE) $@
	@cd $(SOURCE_DIR) && $(MAKE) $@

    
# Rule: doc ----------- View generated man page
doc:
	@cd $(DOCS_DIR) && $(MAKE) $@

    
# Rule: goinstall ----- Install binary locally
goinstall:
	@cd $(SOURCE_DIR) && $(MAKE) $@


# Rule: run ----------- Run source (with test)
run:
	@cd $(SOURCE_DIR) && $(MAKE) $@


# Rule: test ---------- Run all tests
test: lint
	@vgo test all


# Rule: lint ---------- Lint code and check syntax
lint:
	@cd $(SOURCE_DIR); \
	for f in *.$(EXTENSION); \
	do \
		gofmt -w $$f || exit 1 ; \
	done
	@cd $(LIBS_DIR); \
	for f in *.$(EXTENSION); \
	do \
		gofmt -w $$f || exit 1 ; \
	done


# Rule: install-bin --- System wide binary install (sudo)
install-bin:
	@cd $(SOURCE_DIR) && $(MAKE) $@


# Rule: install-man --- System wide man page install (sudo)	
install-man:
	@cd $(DOCS_DIR) && $(MAKE) $@


# Rule: install ------- Install all artifacts system wide (sudo)
install: test install-man install-bin


# Rule: show-version -- Show all dependency versions
show-version:
	@vgo list -m -u


# Rule: clean --------- Remove build go artifacts
clean:
	@rm -vf $(DOCS_DIR)/$(PACKAGE).1
	@rm -vf $(SOURCE_DIR)/$(PACKAGE)

    
# Rule: help ---------- Display Makefile rules
help:
	@grep "^# Rule:" Makefile | sort


# Rule: dist ---------- Create a tarball only 
dist: distclean all test
	@echo "Ensure source code have been commited to Git!"
	@git diff --quiet || exit 1
	@git archive --output=$(PACKAGE)-v$(VERSION).tar.gz --prefix=$(RELEASE)/ HEAD
	@echo "Distrbution $(PACKAGE)-v$(VERSION).tar.gz built"
	@tar -tf $(PACKAGE)-v$(VERSION).tar.gz


# Rule: release ------- Apply Git-tag from Changes version (Maintainer only)
release: dist
	@echo "Tagging release with new v$(VERSION)"    
	@git tag -a v$(VERSION) -m 'Release version v$(VERSION)'
	@mv --force $(PACKAGE)-v$(VERSION).tar.gz ..
	@echo "Writing ../$(PACKAGE)-v$(VERSION).tar.gz"


# Rule: distclean ----- Removes all built artifacts    
distclean: clean
	@rm -vf *.gz


.PHONY: all clean distclean test lint help install install-man install-bin dist version goinstall
            
