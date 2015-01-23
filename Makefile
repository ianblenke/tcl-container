NAMESPACE:=$(shell whoami)

all:
	docker build -t $(NAMESPACE)/tcl-container .
