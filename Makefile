NAMESPACE:=$(shell whoami)
TCL_REPO_BASE:=http://tinycorelinux.net/5.x/x86

all: cache
	docker inspect tinycorelinux > /dev/null 2>&1 || make -C tinycorelinux
	docker build -t iblenke/tcl-container .

cache:
	mkdir -p cache
	cd cache ; \
	for dep in $(shell cat deps.list) ; do \
	  wget $(TCL_REPO_BASE)/tcz/$$dep ; \
	done

clean:
	make -C tinycorelinux clean &&
	rm -fr cache
