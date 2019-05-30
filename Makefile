cluster-up:
	./cluster-providers/up.sh

cluster-down:
	./cluster-providers/down.sh

.PHONY: \
	cluster-up \
	cluster-down 
