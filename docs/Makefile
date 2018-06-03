#!/usr/bin/make -f
#
#  Makefile for generating manpages from markdown with ronn.
#  ronn-format: https://manned.org/ronn-format.7
#
ifneq (,)
$(error This makefile requires GNU Make.)
endif

include ../mk/hello.mk

# Optional variables to set
MANSECT		?= 1
MANCENTER	?= "User Manual"
MANDATE		?= $$(date "+%Y-%m-%d")

MANSRC = $(notdir $(PACKAGE).1.md)

# Rule: all ----------- Build man pages from ronn-source (i.e. markdown)
all:
	@which ronn 1>/dev/null  2>&1 || (echo "Creating manpages from markdown requires: 'sudo aptitude install ruby-ronn'" && exit 1)
	@echo "Manifying $(MANSRC)"
	@ - ronn --roff --manual=$(MANCENTER) --organization=$(PACKAGE) --date=$(MANDATE) $(MANSRC)

    
# Rule: doc ----------- View generated man page   
doc: all
	@man $(PACKAGE).1

    
# Rule: install-man --- System wide man page install (sudo)
install-man: all install-dirs
	@sudo install -m 0644 $(PACKAGE).1 $(MANDIR1)
	@echo "Writing $(MANDIR1)/$(PACKAGE).1"

install-dirs:
	@sudo install -d $(MANDIR1)


# Rule: clean --------- Remove build artifacts
clean:
	@rm -fv $(PACKAGE).1


# Rule: help ---------- Display Makefile rules
help:
	@grep "^# Rule:" Makefile | sort


.PHONY: all clean help install-man install-dirs

