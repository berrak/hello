# Include generic definitions

ifneq (,)
$(error This makefile requires GNU Make.)
endif

## INSTALLATION
#
# System
#
#    sudo make [--dry-run] install
#
# Adjust prefix variable to install to other than system default:
#
#    make [prefix=$HOME/bin] install
#    make [prefix=$HOME/.local/bin] install
#
# For more build information, use:
#
#    make help

EXTENSION   = go

## all template substitutions goes here
MKDIR       = mk
MKFILE      = hello.mk

PACKAGE		= hello
CHANGES_FILE  = Changes
SRC_FILE_NAME     = main.go
SOURCE_DIR      = cmd/hello
DOCS_DIR     = docs
LIBS_DIR     = internal/foo


# Ensure Git is installed
GITBIN := $(shell which git)
ifndef GITBIN
$(error Git version control system is not installed, do 'sudo apt-get install git')
endif


DESTDIR		=
prefix		= /usr
exec_prefix	= $(prefix)
man_prefix	= $(prefix)/share
mandir		= $(man_prefix)/man
bindir		= $(exec_prefix)/bin
sharedir	= $(prefix)/share

BINDIR		= $(DESTDIR)$(bindir)
DOCDIR		= $(DESTDIR)$(sharedir)/doc
LOCALEDIR	= $(DESTDIR)$(sharedir)/locale
SHAREDIR	= $(DESTDIR)$(sharedir)/$(PACKAGE)
LIBDIR		= $(DESTDIR)$(prefix)/lib/$(PACKAGE)
SBINDIR		= $(DESTDIR)$(exec_prefix)/sbin
ETCDIR		= $(DESTDIR)/etc/$(PACKAGE)

# 1 = regular, 5 = conf, 6 = games, 8 = daemons
MANDIR		= $(DESTDIR)$(mandir)
MANDIR1		= $(MANDIR)/man1
MANDIR5		= $(MANDIR)/man5
MANDIR6		= $(MANDIR)/man6
MANDIR8		= $(MANDIR)/man8

# eof

